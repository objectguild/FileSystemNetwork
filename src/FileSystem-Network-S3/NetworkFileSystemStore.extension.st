Extension { #name : #NetworkFileSystemStore }

{ #category : #'*FileSystem-Network-S3' }
NetworkFileSystemStore class >> s3: anUrl [
	| store |
	^ (store := self new)
		initializeWithClient: (S3FileSystemClient store: store url: anUrl) cached;
		open;
		yourself
]
