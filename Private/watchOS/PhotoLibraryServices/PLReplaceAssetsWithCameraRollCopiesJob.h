//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLReplaceAssetsWithCameraRollCopiesJob_h
#define PLReplaceAssetsWithCameraRollCopiesJob_h
@import Foundation;

#include "PLDaemonJob.h"
#include "PLManagedAlbum.h"
#include "PLManagedObjectContext.h"
#include "PLPhotoLibrary.h"

@class NSArray, NSPersistentStoreCoordinator;

@interface PLReplaceAssetsWithCameraRollCopiesJob : PLDaemonJob

@property (copy, nonatomic) NSArray *assets;
@property (retain, nonatomic) PLManagedAlbum *album;
@property (retain, nonatomic) PLPhotoLibrary *photoLibrary;
@property (readonly, nonatomic) PLManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSPersistentStoreCoordinator *coordinator;

/* class methods */
+ (void)replaceAssets:(id)assets withCameraRollCopiesInAlbum:(id)album;

/* instance methods */
- (id)initWithPhotoLibrary:(id)library;
- (void)dealloc;
- (long long)daemonOperation;
- (void)run;
- (void)encodeToXPCObject:(id)xpcobject;
- (id)initFromXPCObject:(id)xpcobject libraryServicesManager:(id)manager;
- (void)runDaemonSide;
- (id)_cameraRollAssetDerivedFromAsset:(id)asset;
@end

#endif /* PLReplaceAssetsWithCameraRollCopiesJob_h */