Class {
	#name : #FTPListResponseTest,
	#superclass : #TestCase,
	#category : #'FileSystem-Tests-Network-FTP'
}

{ #category : #asserting }
FTPListResponseTest >> assert: actual equals: expected description: description [
	^ self
		assert: expected = actual
		description: [ description , ': ' , (self comparingStringBetween: actual and: expected) ]
]

{ #category : #tests }
FTPListResponseTest >> testError [
	self should: [ FTPListResponse parse: '++ unknown garbage +++' ] raise: Error
]

{ #category : #'time travel' }
FTPListResponseTest >> travelToTime: aDateAndTime during: aBlock [
	FTPListResponse traveToTime: aDateAndTime during: aBlock
]
