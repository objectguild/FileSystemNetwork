"
A WebdavFileSystemClient wraps an WebdavClient in an interface defined by NetworkFileSystemClient and used by NetworkFileSystemStore.

It adds additional behaviour for path conversion and parsing WebDav PROPFIND responses into meaningful WebdavPropstat instances.
"
Class {
	#name : #WebdavFileSystemClient,
	#superclass : #NetworkFileSystemClient,
	#instVars : [
		'webDavClient'
	],
	#category : #'FileSystem-Network-Webdav'
}

{ #category : #operations }
WebdavFileSystemClient >> connect [
	webDavClient := WebdavClient new
		url: url;
		yourself
]

{ #category : #operations }
WebdavFileSystemClient >> copy: sourcePath to: destinationPath [
	webDavClient copy: (self stringFromPath: sourcePath) to: (self urlStringFromPath: destinationPath)
]

{ #category : #operations }
WebdavFileSystemClient >> createDirectory: path [
	webDavClient makeCollection: (self stringFromPath: path)
]

{ #category : #attributes }
WebdavFileSystemClient >> defaultWorkingDirectory [
	^ Path from: '/' , url path
]

{ #category : #operations }
WebdavFileSystemClient >> deleteDirectory: path [
	webDavClient delete: (self stringFromPath: path)
]

{ #category : #operations }
WebdavFileSystemClient >> deleteFile: path [
	webDavClient delete: (self stringFromPath: path)
]

{ #category : #operations }
WebdavFileSystemClient >> disconnect [
	webDavClient := nil
]

{ #category : #helpers }
WebdavFileSystemClient >> entryForRoot [
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
WebdavFileSystemClient >> entryFromPropstat: aWebdavPropstat [
	| isCollection |
	isCollection := (aWebdavPropstat propertyAt: 'resourcetype') = 'collection'.
	^ NetworkFileSystemDirectoryEntry new
		path: (self pathFromString: (aWebdavPropstat propertyAt: 'href'));
		type:
				(isCollection
						ifTrue: [ #directory ]
						ifFalse: [ #file ]);
		creationTime: (aWebdavPropstat propertyAt: 'creationdate');
		modificationTime: (aWebdavPropstat propertyAt: 'getlastmodified');
		fileSize:
				(isCollection
						ifTrue: [ 0 ]
						ifFalse: [ aWebdavPropstat propertyAt: 'getcontentlength' ]);
		posixPermissions:
				(isCollection
						ifTrue: [ 8r755 ]
						ifFalse: [ 8r644 ]);
		yourself
]

{ #category : #printing }
WebdavFileSystemClient >> forReferencePrintOn: aStream [
	aStream nextPutAll: 'WebDAV @ '
]

{ #category : #operations }
WebdavFileSystemClient >> lookupEntriesIn: path [
	| propstats entries basename |
	propstats := webDavClient propertyFind: (self stringFromPath: path) depth: 1.
	entries := propstats collect: [ :propstat | self entryFromPropstat: propstat ].
	basename := path basename.
	^ entries reject: [ :entry | entry basename = basename ]
]

{ #category : #operations }
WebdavFileSystemClient >> lookupPath: path [
	| propstats entries basename |
	propstats := webDavClient propertyFind: (self stringFromPath: path) depth: 0.
	entries := propstats collect: [ :propstat | self entryFromPropstat: propstat ].
	basename := path basename.
	^ entries detect: [ :entry | entry basename = basename ] ifNone: [ FileDoesNotExistException signalWith: path ]
]

{ #category : #operations }
WebdavFileSystemClient >> move: sourcePath to: destinationPath [
	webDavClient move: (self stringFromPath: sourcePath) to: (self urlStringFromPath: destinationPath)
]

{ #category : #operations }
WebdavFileSystemClient >> read: path [
	^ webDavClient get: (self stringFromPath: path)
]

{ #category : #accessing }
WebdavFileSystemClient >> rootNode [
	^ self entryForRoot
]

{ #category : #helpers }
WebdavFileSystemClient >> urlStringFromPath: aPath [
	^url copy
		clearPath;
		parsePath: (self stringFromPath: aPath) readStream;
		asString
]

{ #category : #operations }
WebdavFileSystemClient >> write: stringOrByteArray to: path [
	webDavClient put: (self stringFromPath: path) data: stringOrByteArray.
	^ self
]
