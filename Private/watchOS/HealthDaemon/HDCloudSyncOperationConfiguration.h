//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDCloudSyncOperationConfiguration_h
#define HDCloudSyncOperationConfiguration_h
@import Foundation;

#include "HDCloudSyncCachedCloudState.h"
#include "HDCloudSyncComputedState.h"
#include "HDCloudSyncContext.h"
#include "HDCloudSyncRepository.h"

@class CKOperationGroup, HDAssertion, NSDate, NSDictionary, NSMutableSet, NSSet, NSString, NSUUID;

@interface HDCloudSyncOperationConfiguration : NSObject {
  /* instance variables */
  NSMutableSet *_finishedTags;
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _lock;
}

@property BOOL canceled;
@property (readonly, nonatomic) HDCloudSyncRepository *repository;
@property (readonly, nonatomic) CKOperationGroup *operationGroup;
@property (readonly, copy, nonatomic) NSString *syncContainerPrefix;
@property (readonly, copy, nonatomic) HDCloudSyncContext *context;
@property (readonly, nonatomic) HDAssertion *accessibilityAssertion;
@property (readonly, copy, nonatomic) NSUUID *syncIdentifier;
@property (readonly, copy, nonatomic) NSDate *syncDate;
@property (readonly, copy, nonatomic) NSDictionary *analyticsDictionary;
@property (readonly, copy, nonatomic) NSString *shortSyncIdentifier;
@property (readonly, copy, nonatomic) NSString *shortProfileIdentifier;
@property (readonly, copy, nonatomic) HDCloudSyncCachedCloudState *cachedCloudState;
@property (retain) HDCloudSyncComputedState *computedState;
@property (readonly, copy) NSSet *finishedOperationTags;
@property (readonly, nonatomic) BOOL rebaseProhibited;

/* instance methods */
- (id)initWithRepository:(id)repository operationGroup:(id)group syncContainerPrefix:(id)prefix context:(id)context accessibilityAssertion:(id)assertion syncIdentifier:(id)identifier syncDate:(id)date;
- (void)dealloc;
- (id)pushStoresForContainer:(id)container error:(id *)error;
- (id)pushStoreWithIdentifier:(id)identifier container:(id)container error:(id *)error;
- (id)descriptionForSignpost;
- (void)cancelAllOperations;
- (void)didFinishOperationTag:(id)tag;
- (BOOL)satisfiesOperationTagDependencies:(id)dependencies error:(id *)error;
@end

#endif /* HDCloudSyncOperationConfiguration_h */