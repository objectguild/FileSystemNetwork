Class {
	#name : #WebdavFileHandleTest,
	#superclass : #NetworkFileHandleTest,
	#category : #'FileSystem-Tests-Network-Webdav'
}

{ #category : #running }
WebdavFileHandleTest >> createFileSystem [
	^WebdavFileSystemTest createFileSystem
]
