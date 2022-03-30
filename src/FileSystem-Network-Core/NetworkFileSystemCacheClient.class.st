"
A NetworkFileSystemCacheClient is a chim implementing the protocol of NetworkFileSystem client. It wraps another concrete instance of a subclass of NetworkFileSystem and provides a *read cache* for directory and file entries - *not content*!. The cache uses a TTLCache with a very simple invalidation strategy. Basically both caches are completely purged on every operation which might change the FS.

"
Class {
	#name : #NetworkFileSystemCacheClient,
	#superclass : #NetworkFileSystemClient,
	#instVars : [
		'client',
		'entryCache',
		'dirCache'
	],
	#category : #'FileSystem-Network-Core'
}

{ #category : #'instance creation' }
NetworkFileSystemCacheClient class >> on: aNetworkFilesystemClient [
	^ self new
		client: aNetworkFilesystemClient;
		yourself
]

{ #category : #caching }
NetworkFileSystemCacheClient >> cacheExpire: path [
	"If any path should be expired in the cache all entries are removed. Ths logic might not be efficient but is guaranteed to lead to a valid cache!"

	entryCache removeAll.
	dirCache removeAll
]

{ #category : #caching }
NetworkFileSystemCacheClient >> cached [
	^ self
]

{ #category : #accessing }
NetworkFileSystemCacheClient >> client: aNetworkFilesystemClient [ 
	client := aNetworkFilesystemClient
]

{ #category : #operations }
NetworkFileSystemCacheClient >> connect [
	^ client connect
]

{ #category : #operations }
NetworkFileSystemCacheClient >> copy: sourcePath to: destinationPath [
	self
		cacheExpire: sourcePath parent;
		cacheExpire: destinationPath parent.
	^ client copy: sourcePath to: destinationPath
]

{ #category : #operations }
NetworkFileSystemCacheClient >> createDirectory: path [
	self cacheExpire: path parent.
	^ client createDirectory: path
]

{ #category : #attributes }
NetworkFileSystemCacheClient >> defaultWorkingDirectory [
	^ client defaultWorkingDirectory
]

{ #category : #operations }
NetworkFileSystemCacheClient >> deleteDirectory: path [
	self cacheExpire: path parent.
	^ client deleteDirectory: path
]

{ #category : #operations }
NetworkFileSystemCacheClient >> deleteFile: path [
	self cacheExpire: path parent.
	^ client deleteFile: path
]

{ #category : #caching }
NetworkFileSystemCacheClient >> dirCacheAt: path ifAbsentPut: block [
	^ dirCache at: path ifAbsentPut: block
]

{ #category : #operations }
NetworkFileSystemCacheClient >> disconnect [
	^ client disconnect
]

{ #category : #caching }
NetworkFileSystemCacheClient >> entryCacheAt: path ifAbsentPut: block [
	^ entryCache at: path ifAbsentPut: block
]

{ #category : #caching }
NetworkFileSystemCacheClient >> entryCacheAt: path put: value [
	^ entryCache at: path ifAbsentPut: [ value ]
]

{ #category : #printing }
NetworkFileSystemCacheClient >> forReferencePrintOn: aStream [
	^ client forReferencePrintOn: aStream
]

{ #category : #initialization }
NetworkFileSystemCacheClient >> initialize [
	super initialize.
	entryCache := self newCache.
	dirCache := self newCache.

]

{ #category : #operations }
NetworkFileSystemCacheClient >> lookupEntriesIn: path [
	^ self
		dirCacheAt: path
		ifAbsentPut: [ 
			| entries |
			entries := client lookupEntriesIn: path.
			entries do: [ :entry | self entryCacheAt: entry path put: entry ].
			entries ]
]

{ #category : #operations }
NetworkFileSystemCacheClient >> lookupPath: path [
	^ self entryCacheAt: path ifAbsentPut: [ client lookupPath: path ]
]

{ #category : #operations }
NetworkFileSystemCacheClient >> move: sourcePath to: destinationPath [
	self
		cacheExpire: sourcePath parent;
		cacheExpire: destinationPath parent.
	^ client move: sourcePath to: destinationPath
]

{ #category : #caching }
NetworkFileSystemCacheClient >> newCache [
	^ TTLCache new
		timeToLive: 10 minutes asSeconds;
		maximumWeight: 1024;
		yourself
]

{ #category : #operations }
NetworkFileSystemCacheClient >> read: path [
	^ client read: path
]

{ #category : #operations }
NetworkFileSystemCacheClient >> rootNode [
	^ client rootNode
]

{ #category : #caching }
NetworkFileSystemCacheClient >> uncached [
	^ client
]

{ #category : #operations }
NetworkFileSystemCacheClient >> write: stringOrByteArray to: path [
	self cacheExpire: path parent.
	^ client write: stringOrByteArray to: path
]
