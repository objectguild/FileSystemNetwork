"
A NetworkFileSystemStore implements all the neccessary (non-protocol) specific functionality for Stores needed by FileSystem. All protocol-specific operations are forwarded to a (cached) instance of a NetworkFileSystemClient subclass.
"
Class {
	#name : #NetworkFileSystemStore,
	#superclass : #FileSystemStore,
	#instVars : [
		'client'
	],
	#category : #'FileSystem-Network-Core'
}

{ #category : #accessing }
NetworkFileSystemStore class >> delimiter [
	^ $/
]

{ #category : #public }
NetworkFileSystemStore >> basenameFromEntry: entry [
	^ entry basename
]

{ #category : #abstract }
NetworkFileSystemStore >> basicCreationTimeOf: anEntry [
	" the entry contains the seconds since the squeak epoch in local time"

	^ anEntry creationTime translateTo: DateAndTime localOffset
]

{ #category : #abstract }
NetworkFileSystemStore >> basicEntry: directoryEntry path: aPath nodesDo: aBlock [
	| entries |
	[ entries := client lookupEntriesIn: aPath ]
		on: FileDoesNotExistException
		do: [ :ex | self signalDirectoryDoesNotExist: aPath ].
	entries do: [ :each | aBlock value: each ]
]

{ #category : #public }
NetworkFileSystemStore >> basicEntryAt: aPath [
	^ [ client lookupPath: aPath ]
		on: FileDoesNotExistException
		do: [ :ex | #badDirectoryPath ]
]

{ #category : #abstract }
NetworkFileSystemStore >> basicIsDirectory: anEntry [
	^ anEntry isDirectory
]

{ #category : #abstract }
NetworkFileSystemStore >> basicIsFile: anEntry [
	^ anEntry isFile
]

{ #category : #abstract }
NetworkFileSystemStore >> basicIsSymlink: anEntry [
	^ anEntry isSymlink
]

{ #category : #abstract }
NetworkFileSystemStore >> basicModificationTimeOf: anEntry [
	" the entry contains the seconds since the squeak epoch in local time"

	^ anEntry modificationTime translateTo: DateAndTime localOffset
]

{ #category : #abstract }
NetworkFileSystemStore >> basicPosixPermissions: anEntry [
	^ anEntry posixPermissions
]

{ #category : #abstract }
NetworkFileSystemStore >> basicSizeOf: anEntry [
	^ anEntry fileSize
]

{ #category : #accessing }
NetworkFileSystemStore >> client [
	^ client
]

{ #category : #abstract }
NetworkFileSystemStore >> close [
	super close.
	client disconnect
]

{ #category : #private }
NetworkFileSystemStore >> copy: sourcePath ifAbsent: absentBlock to: destinationPath ifPresent: presentBlock fileSystem: aFilesystem [
	(self exists: sourcePath)
		ifFalse: [ ^ absentBlock value ].
	(self exists: destinationPath)
		ifTrue: [ 
			"cannot overwrite destination"
			^ presentBlock value ].
	client copy: sourcePath to: destinationPath
]

{ #category : #abstract }
NetworkFileSystemStore >> createDirectory: path [
	"Create a directory for the argument path. 
	If the path refers to an existing file, raise FileExists.
	If the path refers to an existing directory, raise DirectoryExists.
	If the parent directory of the path does not exist, raise DirectoryDoesNotExist"

	[ client createDirectory: path ]
		on: Error
		do: [ :ex | 
			| parent |
			parent := path parent.
			(self exists: path)
				ifTrue: [ 
					(self isFile: path)
						ifTrue: [ self signalFileExists: path ]
						ifFalse: [ self signalDirectoryExists: path ] ].
			(self isDirectory: parent)
				ifFalse: [ ^ self signalDirectoryDoesNotExist: parent ].
			ex signal ].
	^ self
]

{ #category : #accessing }
NetworkFileSystemStore >> defaultWorkingDirectory [
	^ client defaultWorkingDirectory
]

{ #category : #abstract }
NetworkFileSystemStore >> delete: path [
	(self exists: path)
		ifFalse: [ ^ FileDoesNotExistException signalWith: path ].
	(self isDirectory: path)
		ifTrue: [ client deleteDirectory: path ]
		ifFalse: [ client deleteFile: path ]
]

{ #category : #public }
NetworkFileSystemStore >> entryFromNode: node path: path for: aFileSystem [

	| entryPath reference |

	entryPath := path / (self basenameFromEntry: node).
	reference := FileReference fileSystem: aFileSystem path: entryPath.

	^ MemoryDirectoryEntry reference: reference
]

{ #category : #printing }
NetworkFileSystemStore >> forReferencePrintOn: aStream [
	client forReferencePrintOn: aStream
]

{ #category : #accessing }
NetworkFileSystemStore >> handleClass [
	^ NetworkFileHandle 
]

{ #category : #'initialize-release' }
NetworkFileSystemStore >> initializeWithClient: aNetworkFilesystemClient [
	client := aNetworkFilesystemClient
]

{ #category : #abstract }
NetworkFileSystemStore >> nodeAt: aPath ifPresent: presentBlock ifAbsent: absentBlock [
	| entry |
	aPath isRoot
		ifTrue: [ ^ presentBlock value: client rootNode ].
	entry := self basicEntryAt: aPath.
	^ entry == #badDirectoryPath
		ifTrue: absentBlock
		ifFalse: [ presentBlock value: entry ]
]

{ #category : #abstract }
NetworkFileSystemStore >> open [
	super open.
	client connect
]

{ #category : #operations }
NetworkFileSystemStore >> read: path [
	^ client read: path
]

{ #category : #abstract }
NetworkFileSystemStore >> rename: sourcePath to: destinationPath [
	client move: sourcePath to: destinationPath
]

{ #category : #operations }
NetworkFileSystemStore >> write: bytes to: path [
	client write: bytes to: path
]
