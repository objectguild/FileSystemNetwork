Extension { #name : #NetworkFileSystemStore }

{ #category : #'*FileSystem-Network-FTP' }
NetworkFileSystemStore class >> ftp: anUrl [
	| store |
	^ (store := self new)
		initializeWithClient: (FTPFileSystemClient store: store url: anUrl) cached;
		open;
		yourself
]
