Class {
	#name : #ConfigurationOfFileSystemNetwork,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfFileSystemNetwork
}

{ #category : #'development support' }
ConfigurationOfFileSystemNetwork class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfFileSystemNetwork class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #private }
ConfigurationOfFileSystemNetwork class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfFileSystemNetwork class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfFileSystemNetwork class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfFileSystemNetwork class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfFileSystemNetwork class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfFileSystemNetwork class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfFileSystemNetwork class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfFileSystemNetwork class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/NetworkFileSystem/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' ). ];
			package: #'FileSystem-Tests-Network' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' ). ];
			package: #'FileSystem-Tests-Network' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core';
			package: #'FileSystem-Tests-Network' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-FTP' #'FileSystem-Tests-Network' ). ];
			package: #'FileSystem-Network-Webdav' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-Webdav' with: [
				spec requires: #(#'FileSystem-Network-Webdav' #'FileSystem-Tests-Network' ). ]. ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core';
			package: #'FileSystem-Tests-Network' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-FTP' #'FileSystem-Tests-Network' ). ];
			package: #'FileSystem-Network-Webdav' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-Webdav' with: [
				spec requires: #(#'FileSystem-Network-Webdav' #'FileSystem-Tests-Network' ). ].
		spec 
			group: 'FTP' with: #(#'FileSystem-Network-FTP' );
			group: 'Webdav' with: #(#'FileSystem-Network-Webdav' );
			group: 'Tests' with: #(#'FileSystem-Tests-Network' #'FileSystem-Tests-Network-FTP' #'FileSystem-Tests-Network-Webdav' ). ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline05: spec [
	<version: '0.5-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core';
			package: #'FileSystem-Tests-Network-Core' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-FTP' #'FileSystem-Tests-Network-Core' ). ];
			package: #'FileSystem-Network-Webdav' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-Webdav' with: [
				spec requires: #(#'FileSystem-Network-Webdav' #'FileSystem-Tests-Network-Core' ). ].
		spec 
			group: 'FTP' with: #(#'FileSystem-Network-FTP' );
			group: 'Webdav' with: #(#'FileSystem-Network-Webdav' );
			group: 'Tests' with: #(#'FileSystem-Tests-Network-FTP' #'FileSystem-Tests-Network-Webdav' ). ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline06: spec [
	<version: '0.6-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core';
			package: #'FileSystem-Tests-Network-Core' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-FTP' with: [
				spec requires: #(#'FileSystem-Tests-Network-Core' #'FileSystem-Network-FTP' ). ];
			package: #'FileSystem-Network-Webdav' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-Webdav' with: [
				spec requires: #(#'FileSystem-Tests-Network-Core' #'FileSystem-Network-Webdav' ). ].
		spec 
			group: 'FTP' with: #(#'FileSystem-Network-FTP' );
			group: 'Webdav' with: #(#'FileSystem-Network-Webdav' );
			group: 'Tests' with: #(#'FileSystem-Tests-Network-FTP' #'FileSystem-Tests-Network-Webdav' ). ].

]

{ #category : #baselines }
ConfigurationOfFileSystemNetwork >> baseline07: spec [
	<version: '0.7-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/UdoSchneider/FileSystemNetwork/main/'.
		spec 
			project: 'XMLParser' with: [
				spec
					className: #ConfigurationOfXMLParser;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'XMLWriter' with: [
				spec
					className: #ConfigurationOfXMLWriter;
					versionString: #'stable';
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ];
			project: 'ZincHTTPComponents' with: [
				spec
					className: #ConfigurationOfZincHTTPComponents;
					versionString: #'stable';
					loads: #('Core' 'Zodiac' 'AWS' );
					repository: 'http://smalltalkhub.com/mc/Pharo/MetaRepoForPharo30/main/' ].
		spec 
			package: #'FileSystem-Network-Core';
			package: #'FileSystem-Tests-Network-Core' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Network-FTP' with: [
				spec requires: #(#'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-FTP' with: [
				spec requires: #(#'FileSystem-Tests-Network-Core' #'FileSystem-Network-FTP' ). ];
			package: #'FileSystem-Network-Webdav' with: [
				spec requires: #('XMLParser' 'XMLWriter' 'ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-Webdav' with: [
				spec requires: #(#'FileSystem-Tests-Network-Core' #'FileSystem-Network-Webdav' ). ];
			package: #'FileSystem-Network-S3' with: [
				spec requires: #('ZincHTTPComponents' #'FileSystem-Network-Core' ). ];
			package: #'FileSystem-Tests-Network-S3' with: [
				spec requires: #(#'FileSystem-Network-S3' #'FileSystem-Tests-Network-Core' ). ].
		spec 
			group: 'FTP' with: #(#'FileSystem-Network-FTP' );
			group: 'Webdav' with: #(#'FileSystem-Network-Webdav' );
			group: 'Tests' with: #(#'FileSystem-Tests-Network-FTP' #'FileSystem-Tests-Network-Webdav' ). ].

]

{ #category : #accessing }
ConfigurationOfFileSystemNetwork >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfFileSystemNetwork >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.7-baseline'.

]

{ #category : #accessing }
ConfigurationOfFileSystemNetwork >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfFileSystemNetwork >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.11'.

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version010: spec [
	<version: '0.10' imports: #('0.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.10'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 20:29'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.24';
			package: #'FileSystem-Tests-Network-Core' with: 'FileSystem-Tests-Network-Core-UdoSchneider.1';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.6';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.2';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version011: spec [
	<version: '0.11' imports: #('0.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.11'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 22:13'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.26';
			package: #'FileSystem-Tests-Network-Core' with: 'FileSystem-Tests-Network-Core-UdoSchneider.2';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.9';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.3';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.3';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/2/2014 15:16'.
		spec 
			project: 'XMLParser' with: '1.8.1';
			project: 'XMLWriter' with: '2.4.4';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.10';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version02: spec [
	<version: '0.2' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.2'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/3/2014 08:51'.
		spec 
			project: 'XMLParser' with: '1.8.1';
			project: 'XMLWriter' with: '2.4.4';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.14';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.3'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version03: spec [
	<version: '0.3' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.3'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/3/2014 14:16'.
		spec 
			project: 'XMLParser' with: '1.8.1';
			project: 'XMLWriter' with: '2.4.4';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.16';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.3'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version04: spec [
	<version: '0.4' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.4'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/3/2014 14:22'.
		spec 
			project: 'XMLParser' with: '1.8.1';
			project: 'XMLWriter' with: '2.4.4';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.16';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.3'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version05: spec [
	<version: '0.5' imports: #('0.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.5'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 13:14'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.22';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.7'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version06: spec [
	<version: '0.6' imports: #('0.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.6'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 14:36'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.23';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.8';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version07: spec [
	<version: '0.7' imports: #('0.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.7'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 14:39'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.23';
			package: #'FileSystem-Tests-Network' with: 'FileSystem-Tests-Network-UdoSchneider.8';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version08: spec [
	<version: '0.8' imports: #('0.5-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.8'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 14:50'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.23';
			package: #'FileSystem-Tests-Network-Core' with: 'FileSystem-Tests-Network-Core-UdoSchneider.1';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]

{ #category : #versions }
ConfigurationOfFileSystemNetwork >> version09: spec [
	<version: '0.9' imports: #('0.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.9'.
		spec author: 'UdoSchneider'.
		spec timestamp: '12/21/2014 19:52'.
		spec 
			project: 'XMLParser' with: '1.8.9';
			project: 'XMLWriter' with: '2.4.8';
			project: 'ZincHTTPComponents' with: '2.5.5'.
		spec 
			package: #'FileSystem-Network-Core' with: 'FileSystem-Network-Core-UdoSchneider.23';
			package: #'FileSystem-Tests-Network-Core' with: 'FileSystem-Tests-Network-Core-UdoSchneider.1';
			package: #'FileSystem-Network-FTP' with: 'FileSystem-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-FTP' with: 'FileSystem-Tests-Network-FTP-UdoSchneider.1';
			package: #'FileSystem-Network-Webdav' with: 'FileSystem-Network-Webdav-UdoSchneider.1';
			package: #'FileSystem-Tests-Network-Webdav' with: 'FileSystem-Tests-Network-Webdav-UdoSchneider.1'. ].

]
