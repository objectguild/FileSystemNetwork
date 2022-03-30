Class {
	#name : #S3FileHandleTest,
	#superclass : #NetworkFileHandleTest,
	#category : #'FileSystem-Tests-Network-S3'
}

{ #category : #running }
S3FileHandleTest >> createFileSystem [
	^S3FileSystemTest createFileSystem
]
