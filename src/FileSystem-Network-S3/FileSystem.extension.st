Extension { #name : #FileSystem }

{ #category : #'*FileSystem-Network-S3' }
FileSystem class >> s3: anUrlOrString [
	^ self store: (NetworkFileSystemStore s3: anUrlOrString asUrl)
]
