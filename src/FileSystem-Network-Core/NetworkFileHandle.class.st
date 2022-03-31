"
A NetworkFileHandle is a concrete implementation of FileSystemHandle. It does implement all the functionality to pose as an underlying collection for Streams on it but *does not implement the actual IO operations*!. These are forwarded to a NetworkFileSystemStore which uses protocol dependent clients to actually perform the operations.

Please not that the ivar 'size' is not the size of the 'bytes' buffer. It's the size of ""valid"" data. I.e. you might see ""bytes size > size""
"
Class {
	#name : #NetworkFileHandle,
	#superclass : #FileSystemHandle,
	#instVars : [
		'bytes',
		'size',
		'modified'
	],
	#category : #'FileSystem-Network-Core'
}

{ #category : #public }
NetworkFileHandle >> at: index read: aCollection startingAt: start count: count [
	| max stop |
	max := size - index + 1 min: count.
	stop := start + max - 1.
	aCollection
		replaceFrom: start
		to: stop
		with: bytes
		startingAt: index.
	^ stop - start + 1
]

{ #category : #public }
NetworkFileHandle >> at: first write: aCollection startingAt: start count: count [
	| last |
	writable
		ifFalse: [ Error signal: 'File is read only!' ].
	last := first + count - 1.
	last > bytes size
		ifTrue: [ self grownBy: last - bytes size ].
	bytes
		replaceFrom: first
		to: last
		with: aCollection
		startingAt: start.
	modified := true.
	size := last
]

{ #category : #'streams-compatibility' }
NetworkFileHandle >> binaryReadStream [
	^ ReadStream on: bytes from: 1 to: size
]

{ #category : #'streams-compatibility' }
NetworkFileHandle >> binaryWriteStream [
	^ self writeStream
]

{ #category : #public }
NetworkFileHandle >> close [
	"Upload data to the store if modified."

	modified
		ifTrue: [ self store write: (bytes copyFrom: 1 to: size) to: reference path ].
	bytes := nil.
	modified := false.
	size := nil
]

{ #category : #copying }
NetworkFileHandle >> copyFrom: from to: position [
	^ bytes copyFrom: from to: position
]

{ #category : #public }
NetworkFileHandle >> ensureClosed [
	self close
]

{ #category : #copying }
NetworkFileHandle >> grownBy: length [
	bytes := bytes grownBy: length
]

{ #category : #initialization }
NetworkFileHandle >> initialize [
	super initialize.
	modified := false
]

{ #category : #testing }
NetworkFileHandle >> isOpen [
	^ bytes notNil
]

{ #category : #public }
NetworkFileHandle >> open [
	"Obtaining a NetworkFileHandle for writing marks it as being modified because no append semantics are defined."

	bytes := writable
		ifTrue: [ 
			modified := true.
			ByteArray new ]
		ifFalse: [ 
			modified := false.
			self store read: reference path ].
	size := bytes size
]

{ #category : #public }
NetworkFileHandle >> readStream [
	^ ReadStream on: bytes asString from: 1 to: size
]

{ #category : #accessing }
NetworkFileHandle >> size [
	^ size
]

{ #category : #accessing }
NetworkFileHandle >> store [
	"Helper method to get the actual store. In the current FileHandle implementation the FileHandle does not directly store a reference to the store it points to. So we need to go through the fileSystem here."

	^ reference fileSystem store
]

{ #category : #public }
NetworkFileHandle >> truncateTo: aSize [
	bytes size = aSize
		ifFalse: [ 
			bytes := bytes size < aSize
				ifTrue: [ 
					(ByteArray new: aSize)
						replaceFrom: 1
						to: bytes size
						with: bytes
						startingAt: 1 ]
				ifFalse: [ bytes copyFrom: 1 to: aSize ] ].
	size := bytes size.
	modified := true
]

{ #category : #public }
NetworkFileHandle >> writeStream [
	"Return a writestream on my contents.
	Using myself as target collection allows to share the internal bytearray between multiple streams."

	^ ClosingWriteStream on: self from: 1 to: size
]
