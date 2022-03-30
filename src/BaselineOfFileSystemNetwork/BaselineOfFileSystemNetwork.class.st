Class {
	#name : #BaselineOfFileSystemNetwork,
	#superclass : #BaselineOf,
	#category : #BaselineOfFileSystemNetwork
}

{ #category : #baselines }
BaselineOfFileSystemNetwork >> baseline: spec [
	<baseline>

	spec for: #common do: [ 

		"Dependencies"
		spec 
			baseline: 'XMLParser' with: [ spec loads: #( 'Core' ); repository: 'github://pharo-contributions/XML-XMLParser:master' ] ;
			baseline: 'XMLWriter' with: [ spec loads: #( 'Core' ); repository: 'github://pharo-contributions/XML-XMLWriter:master' ] ;
			baseline: 'ZincHTTPComponents' with: [ spec loads: #( 'Core' 'Zodiac' 'AWS' ); repository: 'github://svenvc/zinc:master' ].

		"Packages"
		spec 
			package: 'FileSystem-Network-Core' ;
			package: 'FileSystem-Network-FTP' with: [ spec requires: #( 'FileSystem-Network-Core' ) ] ;
			package: 'FileSystem-Network-Webdav' with: [ spec requires: #( 'FileSystem-Network-Core' 'XMLParser' 'XMLWriter' 'ZincHTTPComponents' ) ] ;
			package: 'FileSystem-Network-S3' with: [ spec requires: #( 'FileSystem-Network-Core' 'ZincHTTPComponents' ) ] ;

			package: 'FileSystem-Tests-Network-Core' with: [ spec requires: #( 'FileSystem-Network-Core' ) ] ;
			package: 'FileSystem-Tests-Network-FTP' with: [ spec requires: #( 'FileSystem-Tests-Network-Core' 'FileSystem-Network-FTP' ) ] ;
			package: 'FileSystem-Tests-Network-Webdav' with: [ spec requires: #( 'FileSystem-Tests-Network-Core' 'FileSystem-Network-Webdav' ) ] ;
			package: 'FileSystem-Tests-Network-S3' with: [ spec requires: #( 'FileSystem-Tests-Network-Core' 'FileSystem-Network-S3' ) ].

		"Groups"
		spec 
			group: 'default' with: #( 'Tests' ) ;

			group: 'FTP' with: #( 'FileSystem-Network-FTP' ) ;
			group: 'Webdav' with: #( 'FileSystem-Network-Webdav' ) ;
			group: 'S3' with: #( 'FileSystem-Network-S3' ) ;

			group: 'Tests' with: #( 'FileSystem-Tests-Network-FTP' 'FileSystem-Tests-Network-Webdav' 'FileSystem-Tests-Network-S3' ) ;

			group: 'CI' with: #( 'Tests' ).

	]
]
