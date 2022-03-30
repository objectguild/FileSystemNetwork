"
A WebdavPropstat parses a PROPFIND XML Element and returns an instance of WebdavPropstat which provides the data in an appropriate form ""response""
"
Class {
	#name : #WebdavPropstat,
	#superclass : #Object,
	#instVars : [
		'properties'
	],
	#classVars : [
		'PropertyParser'
	],
	#category : #'FileSystem-Network-Webdav'
}

{ #category : #'instance creation' }
WebdavPropstat class >> fromResponse: anXMLElement [
	^ self new
		parseResponse: anXMLElement;
		yourself
]

{ #category : #'class initialization' }
WebdavPropstat class >> initialize [
	"self initialize"

	PropertyParser := Dictionary new
		at: 'creationdate' put: [ :element | self parseDateString: element contentString ];
		at: 'getlastmodified' put: [ :element | self parseDateString: element contentString ];
		at: 'getcontentlength' put: [ :element | element contentString asInteger ];
		at: 'resourcetype' put: [ :element | element firstElement ifNil: [ '' ] ifNotNil: [ :value | value localName ] ];
		at: 'href' put: [ :element | element contentString urlDecoded ];
		yourself
]

{ #category : #parsing }
WebdavPropstat class >> parseDateString: aString [
	^ [ DateAndTime fromString: aString ]
		on: Error
		do: [ :ex | ZnUtils parseHttpDate: aString ]
]

{ #category : #parsing }
WebdavPropstat class >> parseProperty: anXMLElement [
	^ (PropertyParser at: anXMLElement localName ifAbsent: [ #contentString ]) value: anXMLElement
]

{ #category : #helpers }
WebdavPropstat class >> propfindQuery [
	^ self propfindQuery: #('creationdate' 'resourcetype' 'getlastmodified' 'getcontentlength')
]

{ #category : #helpers }
WebdavPropstat class >> propfindQuery: properties [
	| writer |
	(writer := XMLWriter new)
		enablePrettyPrinting;
		xml.
	writer tag
		name: 'a:propfind';
		xmlnsAt: 'a' put: 'DAV:';
		with: [ writer tag: 'a:prop' with: [ properties do: [ :each | writer tag: 'a:' , each ] ] ].
	^ writer contents
]

{ #category : #helpers }
WebdavPropstat class >> propfindQueryAll [
	| writer |
	(writer := XMLWriter new)
		enablePrettyPrinting;
		xml.
	writer tag
		name: 'a:propfind';
		xmlnsAt: 'a' put: 'DAV:';
		with: [ writer tag: 'a:allprop' ].
	^ writer contents
]

{ #category : #initialization }
WebdavPropstat >> initialize [
	super initialize.
	properties := Dictionary new.

]

{ #category : #helpers }
WebdavPropstat >> parseProperty: anXMLElement [
	^ self class parseProperty: anXMLElement
]

{ #category : #helpers }
WebdavPropstat >> parseResponse: aXMLElement [
	properties at: 'href' put: (self parseProperty: (aXMLElement elementAt: 'href')).
	((aXMLElement elementAt: 'propstat') elementAt: 'prop') elements
		do: [ :each | properties at: each localName put: (self parseProperty: each) ]
]

{ #category : #'as yet unclassified' }
WebdavPropstat >> propertyAt: key [
	^ properties at: key
]

{ #category : #'as yet unclassified' }
WebdavPropstat >> propertyAt: key ifAbsent: absentBlock [
	^ properties at: key ifAbsent: absentBlock
]

{ #category : #'as yet unclassified' }
WebdavPropstat >> propertyAt: key put: value [
	^ properties at: key put: value
]
