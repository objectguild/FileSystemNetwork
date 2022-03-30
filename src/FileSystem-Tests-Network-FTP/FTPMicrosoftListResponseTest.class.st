Class {
	#name : #FTPMicrosoftListResponseTest,
	#superclass : #FTPListResponseTest,
	#instVars : [
		'dir',
		'file'
	],
	#category : #'FileSystem-Tests-Network-FTP'
}

{ #category : #running }
FTPMicrosoftListResponseTest >> setUp [
	super setUp.
	dir := FTPListResponse parse: '06-25-07  01:08PM       <DIR>          etc'.
	file := FTPListResponse parse: '11-27-07  08:45PM                23437 README.TXT'
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testDefaultDateMmDdYy [
	| mmDdYy |
	mmDdYy := FTPListResponse parse: '01-02-03  01:08PM       <DIR>          etc'.
	self
		assert: mmDdYy modificationTime
		equals:
			(DateAndTime
				year: 2003
				month: 1
				day: 2
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testFileSize [
	self
		assert: dir size equals: 0;
		assert: file size equals: 23437
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testMicrosoftLikeDir [
	self
		assert: dir name equals: 'etc';
		assert: dir isDirectory;
		deny: dir isFile
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testMicrosoftLikeFile [
	self
		assert: file name equals: 'README.TXT';
		assert: file isFile;
		deny: file isDirectory
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testMicrosoftMtime [
	self
		assert: dir modificationTime
			equals:
				(DateAndTime
						year: 2007
						month: 06
						day: 25
						hour: 13
						minute: 8);
		assert: file modificationTime
			equals:
				(DateAndTime
						year: 2007
						month: 11
						day: 27
						hour: 20
						minute: 45)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseColonDelimitedDate [
	| slashDelimited |
	slashDelimited := FTPListResponse parse: '06:25:07  01:08PM       <DIR>          etc'.
	self
		assert: slashDelimited modificationTime
		equals:
			(DateAndTime
				year: 2007
				month: 06
				day: 25
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseDdMmYy [
	| ddMmYyyy |
	ddMmYyyy := FTPListResponse parse: '25-06-07  01:08PM       <DIR>          etc'.
	self
		assert: ddMmYyyy modificationTime
		equals:
			(DateAndTime
				year: 2007
				month: 6
				day: 25
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseDdMmYyyy [
	| ddMmYyyy |
	ddMmYyyy := FTPListResponse parse: '25-06-2007  01:08PM       <DIR>          etc'.
	self
		assert: ddMmYyyy modificationTime
		equals:
			(DateAndTime
				year: 2007
				month: 6
				day: 25
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseMmDdYy [
	| mmDdYy |
	mmDdYy := FTPListResponse parse: '06-25-07  01:08PM       <DIR>          etc'.
	self
		assert: mmDdYy modificationTime
		equals:
			(DateAndTime
				year: 2007
				month: 6
				day: 25
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseNew [
	self
		assert: dir class equals: FTPMicrosoftListResponse description: 'LIST M$ directory';
		assert: file class equals: FTPMicrosoftListResponse description: 'LIST M$ directory'
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testParseSlashDelimitedDate [
	| slashDelimited |
	slashDelimited := FTPListResponse parse: '06/25/07  01:08PM       <DIR>          etc'.
	self
		assert: slashDelimited modificationTime
		equals:
			(DateAndTime
				year: 2007
				month: 06
				day: 25
				hour: 13
				minute: 8)
]

{ #category : #tests }
FTPMicrosoftListResponseTest >> testZeroHour [
	| ddMmYyyy |
	ddMmYyyy := FTPListResponse parse: '10-15-09  00:34AM       <DIR>          aspnet_client'.
	self assert: ddMmYyyy modificationTime translateToUTC asUnixTime equals: 1255566840
]
