Extension { #name : #ZnResponse }

{ #category : #'*FileSystem-Network-Webdav' }
ZnResponse >> isForbidden [
	^ #(403) includes: self code
]
