Class {
	#name : #FTPUnixListResponseTest,
	#superclass : #FTPListResponseTest,
	#instVars : [
		'dir',
		'file',
		'otherDir',
		'spaces',
		'symlink',
		'olderDate',
		'blockDev',
		'charDev',
		'socketDev',
		'pipeDev',
		'fileNoInodes',
		'fileToday',
		'singleDigitHour'
	],
	#category : #'FileSystem-Tests-Network-FTP'
}

{ #category : #running }
FTPUnixListResponseTest >> setUp [
	super setUp.
	dir := FTPListResponse parse: 'drwxr-xr-x 4 user     group    4096 Jan  1 00:00 etc'.
	file := FTPListResponse parse: '-rw-r--r-- 1 root     other     531 Dec 31 23:59 README'.
	otherDir := FTPListResponse parse: 'drwxr-xr-x 8 1791     600      4096 Mar 11 07:57 forums'.
	spaces := FTPListResponse parse: 'drwxrwxr-x 2 danial   danial     72 May 23 12:52 spaces suck'.
	symlink := FTPListResponse parse: 'lrwxrwxrwx 1 danial   danial      4 Oct 30 15:26 bar -> /etc'.
	olderDate := FTPListResponse parse: '-rwxrwxrwx 1 owner    group  154112 Feb 15  2008 participando.xls'.
	blockDev := FTPListResponse parse: 'brw-r----- 1 root     disk   1,   0 Apr 13  2006 ram0'.
	charDev := FTPListResponse parse: 'crw-rw-rw- 1 root     root   1,   3 Apr 13  2006 null'.
	socketDev := FTPListResponse parse: 'srw-rw-rw- 1 root     root        0 Aug 20 14:15 log'.
	pipeDev := FTPListResponse parse: 'prw-r----- 1 root     adm         0 Nov 22 10:30 xconsole'.
	fileNoInodes := FTPListResponse parse: '-rw-r--r-- foo@localhost foo@localhost  6034 May 14 23:13 index.html'.
	fileToday := FTPListResponse parse: 'crw-rw-rw- 1 root     root   1,   3 Aug 16 14:28 today.txt'.
	singleDigitHour := FTPListResponse parse: '-rw-r--r-- 1 root     other     531 Dec 31  3:59 README'
]

{ #category : #tests }
FTPUnixListResponseTest >> testFileSize [
	self
		assert: dir size equals: 4096;
		assert: file size equals: 531;
		assert: otherDir size equals: 4096;
		assert: spaces size equals: 72;
		assert: symlink size equals: 4;
		assert: olderDate size equals: 154112
]

{ #category : #tests }
FTPUnixListResponseTest >> testParseNew [
	self
		assert: dir class equals: FTPUNIXListResponse description: 'LIST unixish directory';
		assert: file class equals: FTPUNIXListResponse description: 'LIST unixish file';
		assert: otherDir class equals: FTPUNIXListResponse description: 'LIST unixish directory';
		assert: spaces class equals: FTPUNIXListResponse description: 'LIST unixish directory with spaces';
		assert: symlink class equals: FTPUNIXListResponse description: 'LIST unixish symlink';
		assert: blockDev class equals: FTPUNIXListResponse description: 'LIST unix block device';
		assert: charDev class equals: FTPUNIXListResponse description: 'LIST unix char device';
		assert: socketDev class equals: FTPUNIXListResponse description: 'LIST unix socket device';
		assert: pipeDev class equals: FTPUNIXListResponse description: 'LIST unix socket device';
		assert: fileNoInodes class equals: FTPUNIXListResponse description: 'LIST unixish file with no inodes'
]

{ #category : #tests }
FTPUnixListResponseTest >> testSingleDigitHour [
	self
		travelToTime: (DateAndTime year: 2013 month: 8 day: 16)
		during: [ 
			self
				assert: singleDigitHour modificationTime
				equals:
					(DateAndTime
						year: 2013
						month: 12
						day: 31
						hour: 3
						minute: 59) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDateFuture [
	"mtime in the future."

	self
		travelToTime: (DateAndTime year: 2006 month: 3 day: 1)
		during: [ self assert: (FTPListResponse parse: charDev raw) modificationTime equals: (DateAndTime year: 2006 month: 4 day: 13) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDateLeapYear [
	"Parsed during a leap year"

	self
		travelToTime: (DateAndTime year: 2012 month: 1 day: 2)
		during: [ 
			self
				assert: (FTPListResponse parse: symlink raw) modificationTime
				equals:
					(DateAndTime
						year: 2011
						month: 10
						day: 30
						hour: 15
						minute: 26) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDatePastPreviousSameYear [
	"mtimes in the past, previous year"

	self
		travelToTime: (DateAndTime year: 2008 month: 2 day: 4)
		during: [ 
			self
				assert: (FTPListResponse parse: symlink raw) modificationTime
				equals:
					(DateAndTime
						year: 2007
						month: 10
						day: 30
						hour: 15
						minute: 26) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDatePastSameYear [
	"mtimes in the past, same year."

	self
		travelToTime: (DateAndTime year: 2009 month: 1 day: 1)
		during: [ self assert: (FTPListResponse parse: dir raw) modificationTime equals: (DateAndTime year: 2009 month: 1 day: 1) ].
	self
		travelToTime: (DateAndTime year: 2008 month: 4 day: 1)
		during: [ 
			self
				assert: (FTPListResponse parse: otherDir raw) modificationTime
				equals:
					(DateAndTime
						year: 2008
						month: 3
						day: 11
						hour: 7
						minute: 57) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDateTodaySameYear [
	"mtimes today, same year."

	self
		travelToTime: (DateAndTime year: 2013 month: 8 day: 16)
		during: [ 
			self
				assert: (FTPListResponse parse: fileToday raw) modificationTime
				equals:
					(DateAndTime
						year: 2013
						month: 8
						day: 16
						hour: 14
						minute: 28) ]
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeDir [
	self
		assert: dir name equals: 'etc';
		assert: dir isDirectory;
		deny: dir isFile.
	self
		assert: otherDir name equals: 'forums';
		assert: otherDir isDirectory;
		deny: otherDir isFile
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeFile [
	self
		assert: file name equals: 'README';
		assert: file isFile;
		deny: file isDirectory
]

{ #category : #tests }
FTPUnixListResponseTest >> testSmalltalkUnixLikeSymlink [
	self
		assert: symlink name equals: 'bar';
		assert: symlink isSymlink;
		deny: symlink isDirectory;
		deny: symlink isFile
]

{ #category : #tests }
FTPUnixListResponseTest >> testSpacesInUnixDir [
	self
		assert: spaces name equals: 'spaces suck';
		assert: spaces isDirectory;
		deny: spaces isFile
]

{ #category : #tests }
FTPUnixListResponseTest >> testUnixBlockDevice [
	self
		assert: blockDev name equals: 'ram0';
		assert: blockDev isDevice
]

{ #category : #tests }
FTPUnixListResponseTest >> testUnixCharDevice [
	self
		assert: charDev name equals: 'null';
		assert: charDev isDevice
]

{ #category : #tests }
FTPUnixListResponseTest >> testUnixPipeDevice [
	self
		assert: pipeDev name equals: 'xconsole';
		assert: pipeDev isDevice
]

{ #category : #tests }
FTPUnixListResponseTest >> testUnixSocketDevice [
	self
		assert: socketDev name equals: 'log';
		assert: socketDev isDevice
]
