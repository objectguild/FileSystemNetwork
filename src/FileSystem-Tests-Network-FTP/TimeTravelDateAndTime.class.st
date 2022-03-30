Class {
	#name : #TimeTravelDateAndTime,
	#superclass : #Object,
	#instVars : [
		'dateAndTime'
	],
	#category : #'FileSystem-Tests-Network-FTP'
}

{ #category : #accessing }
TimeTravelDateAndTime >> dateAndTime [
	^ dateAndTime
]

{ #category : #accessing }
TimeTravelDateAndTime >> dateAndTime: aDateAndTime [
	dateAndTime := aDateAndTime
]

{ #category : #accessing }
TimeTravelDateAndTime >> now [
	^ dateAndTime
]
