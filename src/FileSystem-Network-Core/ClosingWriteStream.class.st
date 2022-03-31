"
A ClosingWriteStream class is a WriteStream which also #close's it's underlying collection on #close. When used with an NetworkFileHandle as it's collection this #close call is the event for NetworkFileHandle that all data has been written and needs to be transfered the Network Store.

"
Class {
	#name : #ClosingWriteStream,
	#superclass : #WriteStream,
	#category : #'FileSystem-Network-Core'
}

{ #category : #'file open/close' }
ClosingWriteStream >> close [
	collection close.
	^ super close
]

{ #category : #testing }
ClosingWriteStream >> isBinary [ 

	^ true
]
