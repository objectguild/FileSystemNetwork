Class {
	#name : #S3FileSystemTest,
	#superclass : #NetworkFileSystemTest,
	#category : #'FileSystem-Tests-Network-S3'
}

{ #category : #'initialize-release' }
S3FileSystemTest class >> createFileSystem [
	^ FileSystem s3: self testServerUrl
]

{ #category : #'initialize-release' }
S3FileSystemTest >> createFileSystemRootWorkingDirectory [
	^ FileSystem s3: self class testServerUrl asUrl clearPath asString
]

{ #category : #tests }
S3FileSystemTest >> printStringTemplate [
	^ 'S3 @ <1s>'
]

{ #category : #tests }
S3FileSystemTest >> testFileNames [
	super testFileNames	"self fail: 'Umlauts in URLs not yet supported ...'"
]
