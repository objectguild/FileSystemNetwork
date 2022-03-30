Extension { #name : #FileSystem }

{ #category : #'*FileSystem-Network-Webdav' }
FileSystem class >> webdav: anUrlOrString [
	^ self store: (NetworkFileSystemStore webdav: anUrlOrString asUrl)
]
