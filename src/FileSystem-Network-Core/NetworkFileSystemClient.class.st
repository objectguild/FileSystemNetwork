"
A NetworkFileSystemClient is an abstract class which implements the interface for concrete Protocols. 

The seperation is similar to how Disk-based filesystems are implemented. I.e.:

- FileSystem
- DiskStore (node/path handling)
- FileHandle (collection API proxy)
- FilePluginPrims (collection API and IO).

For Network Filesystems the implementation of functionalities is a bit different:

- FileSystem
- NetworkFileSystemStore (node/path handling)
- NetworkFileHandle (collection API on buffer)
- NetworkFileSystemClient subclass (concrete implementation of protocol. E.g. WebDav)

Please note that NetworkFileSystemClient does not have a concept of a ""working directory"". The paths provided to it's instances are always full absolute paths!
"
Class {
	#name : #NetworkFileSystemClient,
	#superclass : #Object,
	#instVars : [
		'store',
		'url'
	],
	#category : #'FileSystem-Network-Core'
}

{ #category : #'instance creation' }
NetworkFileSystemClient class >> store: aNetworkStore url: anUrl [
	^ self new
		initializeWithStore: aNetworkStore url: anUrl;
		yourself
]

{ #category : #caching }
NetworkFileSystemClient >> cached [
	"Return self wrapped by cache"

	^ NetworkFileSystemCacheClient on: self
]

{ #category : #operations }
NetworkFileSystemClient >> connect [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> copy: sourcePath to: destinationPath [
	"Please reimplement if if the underlying FS does support real copy.
	This implementation reads/writes all content through the client and does not support directories!"

	| data |
	data := self read: sourcePath.
	self write: data to: destinationPath
]

{ #category : #operations }
NetworkFileSystemClient >> createDirectory: path [
	self subclassResponsibility
]

{ #category : #attributes }
NetworkFileSystemClient >> defaultWorkingDirectory [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> deleteDirectory: path [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> deleteFile: path [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> disconnect [
	self subclassResponsibility
]

{ #category : #printing }
NetworkFileSystemClient >> forReferencePrintOn: aStream [
	self subclassResponsibility
]

{ #category : #initialization }
NetworkFileSystemClient >> initializeWithStore: aNetworkStore url: anUrl [
	store := aNetworkStore.
	url := anUrl
]

{ #category : #operations }
NetworkFileSystemClient >> lookupEntriesIn: path [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> lookupPath: path [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> move: sourcePath to: destinationPath [
	"Please reimplement if if the underlying FS does support real move.
	This implementation copied the data and deletes the original!"

	| entry |
	self copy: sourcePath to: destinationPath.
	entry := self lookupPath: sourcePath.
	entry isFile
		ifTrue: [ self deleteFile: sourcePath ]
		ifFalse: [ self deleteDirectory: sourcePath ]
]

{ #category : #helpers }
NetworkFileSystemClient >> pathFromString: string [
	^ store pathFromString: string
]

{ #category : #operations }
NetworkFileSystemClient >> read: path [
	self subclassResponsibility
]

{ #category : #operations }
NetworkFileSystemClient >> rootNode [
	self subclassResponsibility
]

{ #category : #helpers }
NetworkFileSystemClient >> stringFromPath: aPath [
	^ store stringFromPath: aPath
]

{ #category : #caching }
NetworkFileSystemClient >> uncached [
	"Return uncached"

	^ self
]

{ #category : #operations }
NetworkFileSystemClient >> write: bytes to: path [
	self subclassResponsibility
]
