//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLFileSystemCapabilities_h
#define PLFileSystemCapabilities_h
@import Foundation;

@class NSError, NSString;

@interface PLFileSystemCapabilities : NSObject {
  /* instance variables */
  unsigned int _interfacesCapabilities;
  unsigned int _nativeCommonAttributes;
  char _fstypename[16];
}

@property (readonly) BOOL isReadOnly;
@property (readonly) BOOL isCloneCapable;
@property (readonly) BOOL isWholeFileLockCapable;
@property (readonly) BOOL isGenCountCapable;
@property (readonly) BOOL isSecludeRenameCapable;
@property (readonly) BOOL isLocalVolume;
@property (readonly) BOOL isInternalVolume;
@property (readonly) BOOL isRootFileSystemVolume;
@property (readonly) BOOL supportsDataProtection;
@property (readonly) NSString *fileSystemTypeName;
@property (readonly) BOOL isNetworkVolume;
@property (readonly) BOOL isCentralizedCacheDeleteCapable;
@property (readonly) BOOL isCoreDataCapable;
@property (readonly) BOOL isCloudPhotoLibraryCapable;
@property (readonly) BOOL isValid;
@property (readonly) NSError *error;

/* class methods */
+ (id)capabilitiesWithURL:(id)url;
+ (unsigned long long)minimumAvailableBytesRequiredForLibraryOpen;

/* instance methods */
- (BOOL)determineCapabilitiesWithURL:(id)url error:(id *)error;
- (id)description;
@end

#endif /* PLFileSystemCapabilities_h */