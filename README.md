# FileSystemNetwork
FTP and WebDAV Plugins for Pharo's FileSystem

The original author is Udo Schneider. There is still a copy of the original repository of SmalltalkHub to be found here: http://smalltalkhub.com/UdoSchneider/FileSystemNetwork.

The original code has been adapted to work on Pharo 8.0.

## Project info
The "FileSystemNetwork" project is a small library which adds WebDAV and FTP support to Pharo's FileSystem framework. This allows you to use remote WebDAV and FTP locations with the same (FileSystem) API that's used for disk access.

## Loading
The original `ConfigurationOfFileSystemNetwork` has been replaced with `BaselineOfFileSystemNetwork`. The baseline defines the groups `Core` and `Tests`, with the default only loading the `Core` group.

```Smalltalk
Metacello new
  baseline: 'FileSystemNetwork';
  repository: 'github://objectguild/FileSystemNetwork:main';
  load.
```