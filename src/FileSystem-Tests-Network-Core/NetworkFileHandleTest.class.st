Class {
	#name : #NetworkFileHandleTest,
	#superclass : #FileSystemHandleTest,
	#category : #'FileSystem-Tests-Network-Core-FileSystem-Tests-Network-Core'
}

{ #category : #testing }
NetworkFileHandleTest class >> isAbstract [
	^ self = NetworkFileHandleTest or: [ super isAbstract ]
]

{ #category : #running }
NetworkFileHandleTest >> tearDown [
	super tearDown.
	filesystem close.
]
