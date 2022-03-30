Extension { #name : #NetworkFileSystemDirectoryEntry }

{ #category : #'*FileSystem-Network-Webdav' }
NetworkFileSystemDirectoryEntry class >> fromPropstat: aWebdavPropstat [
	^ self new
		basename: (($/ split: (aWebdavPropstat propertyAt: 'href')) reject: [ :each | each isEmpty ]) last;
		type:
				((aWebdavPropstat propertyAt: 'resourcetype') = 'collection'
						ifTrue: [ #directory ]
						ifFalse: [ #file ]);
		yourself
]
