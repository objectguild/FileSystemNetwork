Class {
	#name : #S3FileSystemClient,
	#superclass : #NetworkFileSystemClient,
	#instVars : [
		's3Client',
		'bucket'
	],
	#category : #'FileSystem-Network-S3'
}

{ #category : #operations }
S3FileSystemClient >> connect [
	s3Client := ZnAWSS3Client new
		accessKeyId: url username;
		secretAccessKey: url password.
	bucket := url host
]

{ #category : #operations }
S3FileSystemClient >> createDirectory: path [
	(self keysWithPrefix: path) notEmpty
		ifTrue: [ DirectoryExists signal ].
	(path parent isRoot not and: [ (self keysWithPrefix: path parent) isEmpty ])
		ifTrue: [ DirectoryDoesNotExist signal ].
	s3Client at: bucket -> ((self stringFromPath: path) , '/') put: (ZnEntity bytes: #[])
]

{ #category : #attributes }
S3FileSystemClient >> defaultWorkingDirectory [
	^ Path from: '/' , url path
]

{ #category : #operations }
S3FileSystemClient >> deleteDirectory: path [
	| keys |
	keys := self keysWithPrefix: path.
	keys do: [ :key | s3Client remove: key value ]
]

{ #category : #operations }
S3FileSystemClient >> deleteFile: path [
	s3Client remove: bucket -> (self stringFromPath: path)
]

{ #category : #operations }
S3FileSystemClient >> disconnect [
	s3Client := nil
]

{ #category : #helpers }
S3FileSystemClient >> entryForRoot [
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
S3FileSystemClient >> entryFromKey: aZnAWSS3Key [
	| key isDirectory |
	key := aZnAWSS3Key key.
	isDirectory := false.
	(key endsWith: '/')
		ifTrue: [ 
			isDirectory := true.
			key := key allButLast ].
	(key endsWith: '_$folder$')
		ifTrue: [ 
			isDirectory := true.
			key := key allButLast: 9 ].
	^ NetworkFileSystemDirectoryEntry new
		path: (self pathFromString: key);
		type:
				(isDirectory
						ifTrue: [ #directory ]
						ifFalse: [ #file ]);
		creationTime: aZnAWSS3Key lastModified;
		modificationTime: aZnAWSS3Key lastModified;
		fileSize: aZnAWSS3Key size;
		posixPermissions:
				(isDirectory
						ifTrue: [ 8r755 ]
						ifFalse: [ 8r644 ]);
		yourself
]

{ #category : #printing }
S3FileSystemClient >> forReferencePrintOn: aStream [
	aStream nextPutAll: 'S3 @ '
]

{ #category : #helpers }
S3FileSystemClient >> keysWithPrefix: path [
	^ s3Client keysIn: bucket query: (Dictionary newFrom: {('prefix' -> (self stringFromPath: path))})
]

{ #category : #operations }
S3FileSystemClient >> lookupEntriesIn: path [
	| keys entries |

	keys := self keysWithPrefix: path.
	entries := keys collect: [ :key | self entryFromKey: key ].
	^ entries select: [ :entry | entry path parent = path ]
]

{ #category : #operations }
S3FileSystemClient >> lookupPath: path [
	| entries  keys |
	keys := self keysWithPrefix: path.
	entries := keys collect: [ :key | self entryFromKey: key ].
	^ entries detect: [ :entry | entry path = path ] ifNone: [ FileDoesNotExist signalWith: path ]
]

{ #category : #operations }
S3FileSystemClient >> move: sourcePath to: destinationPath [
	(self keysWithPrefix: destinationPath parent) isEmpty
		ifTrue: [ DirectoryDoesNotExist signal ].
	super move: sourcePath to: destinationPath
]

{ #category : #helpers }
S3FileSystemClient >> pathFromString: string [
	^ store pathFromString: '/' , string asByteArray utf8Decoded
]

{ #category : #operations }
S3FileSystemClient >> read: path [
	| response |
	response := s3Client at: bucket -> (self stringFromPath: path).
	response isNotFound
		ifTrue: [ FileDoesNotExist signal ].
	^ response contents ifNil: [ '' ]
]

{ #category : #operations }
S3FileSystemClient >> rootNode [
	^ self entryForRoot
]

{ #category : #helpers }
S3FileSystemClient >> stringFromPath: aPath [
	^ (store stringFromPath: aPath) allButFirst utf8Encoded asString
]

{ #category : #operations }
S3FileSystemClient >> write: stringOrByteArray to: path [
	s3Client at: bucket -> (self stringFromPath: path) put: (ZnEntity bytes: stringOrByteArray).
	^ self
]
