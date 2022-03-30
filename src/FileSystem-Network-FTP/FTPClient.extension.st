Extension { #name : #FTPClient }

{ #category : #'*FileSystem-Network-FTP' }
FTPClient >> checkResponse [
	"Catch a 550 response code and signal as FileDoesNotExist instead of TelnetProtocolError. The FileDoesNotExist is handled by the NetworkFileSystemStore"

	self
		checkResponseOnError: [ :response | 
			(self responseCode = 550
				ifTrue: [ FileDoesNotExistException ]
				ifFalse: [ TelnetProtocolError protocolInstance: self ]) signal: response ]
		onWarning: [ :response | (TelnetProtocolError protocolInstance: self) signal: response ]
]

{ #category : #'*FileSystem-Network-FTP' }
FTPClient >> getDirectoryResponses [
	^ self getDirectory lines collect: [ :line | FTPListResponse parse: line ]
]
