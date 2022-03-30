Class {
	#name : #FTPFileHandleTest,
	#superclass : #NetworkFileHandleTest,
	#category : #'FileSystem-Tests-Network-FTP'
}

{ #category : #running }
FTPFileHandleTest >> createFileSystem [
	^FTPFileSystemTest createFileSystem
]
