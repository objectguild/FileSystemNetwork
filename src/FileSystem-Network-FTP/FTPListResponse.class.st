Class {
	#name : #FTPListResponse,
	#superclass : #Object,
	#instVars : [
		'name',
		'type',
		'size',
		'modificationTime'
	],
	#classVars : [
		'DateAndTimeClass'
	],
	#category : #'FileSystem-Network-FTP'
}

{ #category : #'time travel' }
FTPListResponse class >> dateAndTimeClass [
	DateAndTimeClass ifNil: [ DateAndTimeClass := self defaultDateAndTimeClass ].
	^ DateAndTimeClass
]

{ #category : #'time travel' }
FTPListResponse class >> defaultDateAndTimeClass [
	^ DateAndTime
]

{ #category : #'instance creation' }
FTPListResponse class >> parse: aString [
	self subclasses do: [ :each | (each new parse: aString) ifNotNil: [ :value | ^ value ] ].
	^ self error: ('Could not parse <1p> since none of the parsers was up to the task' expandMacrosWith: aString)
]

{ #category : #'instance creation' }
FTPListResponse class >> rootDirectory [
	^ self new
		basename: '/';
		type: #directory;
		yourself
]

{ #category : #'time travel' }
FTPListResponse class >> traveToTime: aDateAndTime during: aBlock [
	DateAndTimeClass := TimeTravelDateAndTime new dateAndTime: aDateAndTime.
	aBlock
		ensure: [ DateAndTimeClass := self defaultDateAndTimeClass ]
]

{ #category : #accessing }
FTPListResponse >> creationTime [
	^ modificationTime
]

{ #category : #'time travel' }
FTPListResponse >> dateAndTimeNow [
	^ self class dateAndTimeClass now
]

{ #category : #testing }
FTPListResponse >> isDevice [
	^ type = #device
]

{ #category : #testing }
FTPListResponse >> isDirectory [
	^ type = #directory
]

{ #category : #testing }
FTPListResponse >> isFile [
	^ type = #file
]

{ #category : #testing }
FTPListResponse >> isSymlink [
	^ type = #symlink
]

{ #category : #accessing }
FTPListResponse >> modificationTime [
	^ modificationTime
]

{ #category : #accessing }
FTPListResponse >> name [
	^ name
]

{ #category : #parsing }
FTPListResponse >> parse: aString [
	self subclassResponsibility
]

{ #category : #accessing }
FTPListResponse >> size [
	^ size
]

{ #category : #accessing }
FTPListResponse >> type [
	^ type
]
