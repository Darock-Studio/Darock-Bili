//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLFileSystemVolumeManager_h
#define PLFileSystemVolumeManager_h
@import Foundation;

@class NSFileManager, NSMapTable, NSMutableDictionary;
@protocol OS_dispatch_queue;

@interface PLFileSystemVolumeManager : NSObject {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_synchronizationQueue;
  NSFileManager *_fileManager;
  NSMutableDictionary *_mountedVolumeURLsByUuid;
  NSMutableDictionary *_registeredFileSystemVolumesByUuid;
  NSMapTable *_mocsByVolume;
}

/* class methods */
+ (id)sharedFileSystemVolumeManager;

/* instance methods */
- (id)initSharedVolumeManager;
- (void)dealloc;
- (id)volumeForURL:(id)url context:(id)context;
- (void)registerPLFileSystemVolume:(id)volume;
- (void)unregisterPLFileSystemVolume:(id)volume;
- (void)_updateOfflineStates;
- (void)_updateMountedVolumeURLs;
@end

#endif /* PLFileSystemVolumeManager_h */