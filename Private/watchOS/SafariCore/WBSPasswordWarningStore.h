//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef WBSPasswordWarningStore_h
#define WBSPasswordWarningStore_h
@import Foundation;

@class NSMutableDictionary, NSURL;
@protocol OS_dispatch_queue, {unique_ptr<SafariShared::SuddenTerminationDisabler, std::default_delete<SafariShared::SuddenTerminationDisabler>>="__ptr_"{__compressed_pair<SafariShared::SuddenTerminationDisabler *, std::default_delete<SafariShared::SuddenTerminationDisabler>>="__value_"^{SuddenTerminationDisabler}}};

@interface WBSPasswordWarningStore : NSObject {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_queue;
  struct unique_ptr<SafariShared::SuddenTerminationDisabler, std::default_delete<SafariShared::SuddenTerminationDisabler>> { struct __compressed_pair<SafariShared::SuddenTerminationDisabler *, std::default_delete<SafariShared::SuddenTerminationDisabler>> { struct SuddenTerminationDisabler *__value_; } __ptr_; } _suddenTerminationDisabler;
  BOOL _hasPendingChanges;
  NSURL *_backingStoreURL;
  NSMutableDictionary *_lastWarningDatesByPersistentIdentifier;
}

/* class methods */
+ (id)sharedStore;

/* instance methods */
- (id)_initWithBackingStoreURL:(id)url;
- (id)_initWithDefaultBackingStore;
- (void)_loadStoreIfNecessary;
- (void)_saveStoreSoon;
- (void)_saveStoreNow;
- (void)saveStoreSynchronously;
- (void)getContainsPersistentIdentifier:(id)identifier completionHandler:(id /* block */)handler;
- (void)_addPersistentIdentifier:(id)identifier withLastWarningDate:(id)date;
- (void)addPersistentIdentifier:(id)identifier;
- (void)clearStoreSynchronously;
- (void)synchronousyClearIdentifiersAddedAfterDate:(id)date;
@end

#endif /* WBSPasswordWarningStore_h */