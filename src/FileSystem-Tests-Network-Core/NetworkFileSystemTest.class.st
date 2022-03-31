Class {
	#name : #NetworkFileSystemTest,
	#superclass : #FileSystemTest,
	#classInstVars : [
		'TestServerUrl'
	],
	#category : #'FileSystem-Tests-Network-Core'
}

{ #category : #testing }
NetworkFileSystemTest class >> isAbstract [
	^ self = NetworkFileSystemTest or: [ super isAbstract ]
]

{ #category : #accessing }
NetworkFileSystemTest class >> reset [
	TestServerUrl := nil
]

{ #category : #accessing }
NetworkFileSystemTest class >> testServerUrl [
	TestServerUrl
		ifNil: [ TestServerUrl := UIManager default request: ('Test Server URL for <1s> Filesystem tests?' expandMacrosWith: self name) ].
	^ TestServerUrl
]

{ #category : #accessing }
NetworkFileSystemTest class >> testServerUrl: aString [

	TestServerUrl := aString
]

{ #category : #'initialize-release' }
NetworkFileSystemTest >> createFileSystem [
	^ self class createFileSystem
]

{ #category : #'initialize-release' }
NetworkFileSystemTest >> createFileSystemRootWorkingDirectory [
	self subclassResponsibility 
]

{ #category : #tests }
NetworkFileSystemTest >> printStringTemplate [
	self subclassResponsibility 
]

{ #category : #'initialize-release' }
NetworkFileSystemTest >> tearDown [
	super tearDown.
	filesystem close.
]

{ #category : #tests }
NetworkFileSystemTest >> testDefaultWorkingDirectory [
	filesystem := self createFileSystemRootWorkingDirectory.
	self assert: filesystem workingDirectory isRoot
]

{ #category : #tests }
NetworkFileSystemTest >> testEqual [
	| other |
	other := self createFileSystem.
	self deny: filesystem = other
]

{ #category : #tests }
NetworkFileSystemTest >> testWorkingDirectory [
	self
		assert: filesystem workingDirectory asString
		equals: (self printStringTemplate expandMacrosWith: (filesystem stringFromPath: filesystem workingDirectory path))
]
