Extension { #name : #NetworkFileSystemStore }

{ #category : #'*FileSystem-Network-Webdav' }
NetworkFileSystemStore class >> webdav: anUrl [
	| store |
	^ (store := self new)
		initializeWithClient: (WebdavFileSystemClient store: store url: anUrl) cached;
		open;
		yourself
]
