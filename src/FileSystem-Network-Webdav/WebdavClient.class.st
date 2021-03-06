"
A WebdavClient extends ZnClient and implements WebDav specific HTTP behaviour.
"
Class {
	#name : #WebdavClient,
	#superclass : #ZnClient,
	#instVars : [
		'defaultReader'
	],
	#category : #'FileSystem-Network-Webdav'
}

{ #category : #operations }
WebdavClient >> copy: sourcePath to: destinationUrl [
	self
		resetEntity;
		webdavPath: sourcePath;
		headerAt: 'destination' put: destinationUrl;
		method: #COPY;
		execute.
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ]
]

{ #category : #operations }
WebdavClient >> delete: path [
	self delete: path depth: 'infinity'
]

{ #category : #operations }
WebdavClient >> delete: path depth: depth [
	self
		resetEntity;
		webdavPath: path;
		headerAt: 'Depth' put: depth asString;
		delete.
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ]
]

{ #category : #operations }
WebdavClient >> get: path [
	self
		resetEntity;
		beBinary;
		webdavPath: path;
		get;
		resetReader. "Binary used for GET, can reset immediately for next use"
	self isNotFound
		ifTrue: [ ^ FileDoesNotExistException signal ].
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ].
	^ self contents ifNil: [ ByteArray new ]
]

{ #category : #initialization }
WebdavClient >> initialize [ 

	super initialize. 

	"Save default reader to reset for non-binary requests."
	defaultReader := self reader
]

{ #category : #testing }
WebdavClient >> isForbidden [
	"Return true it the last executed HTTP request returned an HTTP forbidden response code."

	^ response ifNil: [ self error: 'Request not yet executed' ] ifNotNil: [ response isForbidden ]
]

{ #category : #operations }
WebdavClient >> makeCollection: path [
	self
		resetEntity;
		webdavPath: path;
		method: #MKCOL;
		execute.
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ]
]

{ #category : #operations }
WebdavClient >> move: sourcePath to: destinationUrl [
	self
		resetEntity;
		webdavPath: sourcePath;
		headerAt: 'destination' put: destinationUrl;
		method: #MOVE;
		execute.
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ]
]

{ #category : #helpers }
WebdavClient >> parsePropfindResponse: aString [
	^ (((XMLDOMParser parse: aString) allElementsNamed: 'response')
		collect: [ :eachResponse | WebdavPropstat fromResponse: eachResponse ]) asArray
]

{ #category : #operations }
WebdavClient >> propertyFind: path depth: depth [
	^ self propertyFind: path query: WebdavPropstat propfindQueryAll depth: depth
]

{ #category : #operations }
WebdavClient >> propertyFind: path query: propfindQuery depth: depth [
	self
		resetEntity;
		webdavPath: path;
		headerAt: 'Depth' put: depth asString;
		entity: (ZnEntity xml: propfindQuery);
		method: #PROPFIND;
		execute.
	self isNotFound
		ifTrue: [ ^ FileDoesNotExistException signalWith: path ].
	(self  isSuccess or: [ self  response code = 207 ])
		ifFalse: [ ^ Error signal: self  contents ].
	^ self parsePropfindResponse: self  contents
]

{ #category : #operations }
WebdavClient >> put: path data: data [
	self
		resetEntity;
		webdavPath: path;
		entity: (ZnEntity bytes: data);
		put.
	self isForbidden
		ifTrue: [ ^ Error signal: 'Access forbidden' ].
	self isSuccess
		ifFalse: [ ^ Error signal: self contents ]
]

{ #category : #'accessing request' }
WebdavClient >> resetPath [
	self path: '/'
]

{ #category : #initialization }
WebdavClient >> resetReader [ 

	self optionAt: #reader put: defaultReader
]

{ #category : #accessing }
WebdavClient >> webdavPath: path [
	self
		resetPath;
		addPath: (Path from: path)
]
