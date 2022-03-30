Extension { #name : #FileSystem }

{ #category : #'*FileSystem-Network-FTP' }
FileSystem class >> ftp: anUrlOrString [
	^ self store: (NetworkFileSystemStore ftp: anUrlOrString asUrl)
]
