"
A NetworkFileSystemDirectoryEntry implementings a Directory Entry. If you want to add your own protocol clients then they need to return instaces of this class.
"
Class {
	#name : #NetworkFileSystemDirectoryEntry,
	#superclass : #Object,
	#instVars : [
		'path',
		'type',
		'fileSize',
		'creationTime',
		'modificationTime',
		'posixPermissions'
	],
	#category : #'FileSystem-Network-Core'
}

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> basename [
	^ path basename
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> basename: aString [
	basename := aString
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> creationTime [
	^ creationTime
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> creationTime: aDateAndTime [
	creationTime := aDateAndTime
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> fileSize [
	^ fileSize
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> fileSize: anInteger [
	fileSize := anInteger
]

{ #category : #testing }
NetworkFileSystemDirectoryEntry >> isDirectory [
	^ type = #directory
]

{ #category : #testing }
NetworkFileSystemDirectoryEntry >> isFile [
	^ type = #file
]

{ #category : #testing }
NetworkFileSystemDirectoryEntry >> isSymlink [
	^ type = #symlink
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> modificationTime [
	^ modificationTime
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> modificationTime: aDateAndTime [
	modificationTime := aDateAndTime
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> path [
	^ path
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> path: aPath [
	path := aPath
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> posixPermissions [
	^ posixPermissions
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> posixPermissions: anInteger [
	posixPermissions := anInteger
]

{ #category : #'as yet unclassified' }
NetworkFileSystemDirectoryEntry >> printOn: aStream [
	super printOn: aStream.
	aStream space
		nextPut: $(;
		print: path;
		nextPut: $)
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> type [
	^ type
]

{ #category : #accessing }
NetworkFileSystemDirectoryEntry >> type: aSymbol [
	type := aSymbol
]
