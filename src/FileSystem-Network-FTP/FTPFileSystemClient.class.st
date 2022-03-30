"
A FTPFileSystemClient wraps an FTPClient in an interface defined by NetworkFileSystemClient and used by NetworkFileSystemStore.

It adds additional behaviour by reconnecting timed-out connections (see #ensureOpenConnectionWhile:), keeping track of the working directory on the server (see #ensureCwd:; which is different from the working directory of the FileSystem!!!), path conversion and parsing FTP List responses into meaningful FTPListResponse instances.
"
Class {
	#name : #FTPFileSystemClient,
	#superclass : #NetworkFileSystemClient,
	#instVars : [
		'ftpClient',
		'serverCwdPath'
	],
	#category : #'FileSystem-Network-FTP'
}

{ #category : #operations }
FTPFileSystemClient >> connect [
	ftpClient := FTPClient openOnHostNamed: url host port: (url port ifNil: [ 21 ]).
	url username isNil
		ifTrue: [ ftpClient loginUser: 'anonymous' password: InternetConfiguration getEmail ]
		ifFalse: [ ftpClient loginUser: url username password: url password ].
	ftpClient binary.
	serverCwdPath := nil
]

{ #category : #operations }
FTPFileSystemClient >> createDirectory: path [
	self ensureOpenConnectionWhile: [ ftpClient makeDirectory: (self stringFromPath: path) ]
]

{ #category : #attributes }
FTPFileSystemClient >> defaultWorkingDirectory [
	^ Path from: '/' , url path
]

{ #category : #operations }
FTPFileSystemClient >> deleteDirectory: path [
	self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path parent.
			ftpClient deleteDirectory: path basename ]
]

{ #category : #operations }
FTPFileSystemClient >> deleteFile: path [
	self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path parent.
			ftpClient deleteFileNamed: path basename ]
]

{ #category : #operations }
FTPFileSystemClient >> disconnect [
	ftpClient
		quit;
		close.
	ftpClient := nil
]

{ #category : #helpers }
FTPFileSystemClient >> ensureCwd: path [
	serverCwdPath ~= path
		ifTrue: [ 
			ftpClient changeDirectoryTo: (self stringFromPath: path).
			serverCwdPath := path ]
]

{ #category : #helpers }
FTPFileSystemClient >> ensureOpenConnectionWhile: aBlock [
	^ aBlock
		on: ConnectionClosed
		do: [ :ex | 
			self connect.
			aBlock value ]
]

{ #category : #helpers }
FTPFileSystemClient >> entryForRoot [
	^ NetworkFileSystemDirectoryEntry new
		path: Path root;
		type: #directory;
		creationTime: (DateAndTime fromUnixTime: 0);
		modificationTime: (DateAndTime fromUnixTime: 0);
		fileSize: 0;
		posixPermissions: 8r755;
		yourself
]

{ #category : #helpers }
FTPFileSystemClient >> entryFromResponse: aFTPListResponse [
	^ NetworkFileSystemDirectoryEntry new
		path: (self pathFromString: (self stringFromPath: serverCwdPath / aFTPListResponse name));
		type: aFTPListResponse type;
		creationTime: aFTPListResponse creationTime;
		modificationTime: aFTPListResponse modificationTime;
		fileSize: aFTPListResponse size;
		posixPermissions: aFTPListResponse posixPermissions;
		yourself
]

{ #category : #operations }
FTPFileSystemClient >> entryFromString: line [
	^ (FTPListResponse parse: line) 
]

{ #category : #printing }
FTPFileSystemClient >> forReferencePrintOn: aStream [
	aStream nextPutAll: 'FTP @ '
]

{ #category : #operations }
FTPFileSystemClient >> lookupEntriesIn: path [
	| responses |
	^ self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path.
			responses := ftpClient getDirectoryResponses.
			responses collect: [ :response | self entryFromResponse: response ] ]
]

{ #category : #operations }
FTPFileSystemClient >> lookupPath: path [
	| responses entries |
	^ self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path parent.
			responses := ftpClient getDirectoryResponses.
			responses isEmpty
				ifTrue: [ ^ FileDoesNotExist signalWith: path ].
			entries := responses collect: [ :response | self entryFromResponse: response ].
			entries detect: [ :entry | entry basename = path basename ] ifNone: [ FileDoesNotExist signalWith: path ] ]
]

{ #category : #operations }
FTPFileSystemClient >> move: sourcePath to: destinationPath [
	^ self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: sourcePath parent.
			ftpClient renameFileNamed: sourcePath basename to: (self stringFromPath: destinationPath) ]
]

{ #category : #operations }
FTPFileSystemClient >> read: path [
	^ self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path parent.
			ftpClient getFileNamed: path basename ]
]

{ #category : #operations }
FTPFileSystemClient >> rootNode [
	^ self entryForRoot
]

{ #category : #converting }
FTPFileSystemClient >> stringFromPath: path [
	^ store stringFromPath: path
]

{ #category : #operations }
FTPFileSystemClient >> write: stringOrByteArray to: path [
	^ self
		ensureOpenConnectionWhile: [ 
			self ensureCwd: path parent.
			ftpClient putFileStreamContents: stringOrByteArray readStream as: path basename.
			self ]
]
