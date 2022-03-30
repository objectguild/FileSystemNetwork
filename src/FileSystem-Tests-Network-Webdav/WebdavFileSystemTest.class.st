Class {
	#name : #WebdavFileSystemTest,
	#superclass : #NetworkFileSystemTest,
	#category : #'FileSystem-Tests-Network-Webdav'
}

{ #category : #'initialize-release' }
WebdavFileSystemTest class >> createFileSystem [
	^ FileSystem webdav: self testServerUrl
]

{ #category : #'initialize-release' }
WebdavFileSystemTest >> createFileSystemRootWorkingDirectory [
	^ FileSystem webdav: self class testServerUrl asUrl clearPath asString
]

{ #category : #tests }
WebdavFileSystemTest >> printStringTemplate [
	^ 'WebDAV @ <1s>'
]
