//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDCloudSyncManagerLookupTask_h
#define HDCloudSyncManagerLookupTask_h
@import Foundation;

#include "HDCloudSyncManagerPipelineTask.h"
#include "HDCloudSyncPipelineStageLookupParticipant.h"

@class CKShareParticipant, CKUserIdentityLookupInfo;

@interface HDCloudSyncManagerLookupTask : HDCloudSyncManagerPipelineTask {
  /* instance variables */
  CKUserIdentityLookupInfo *_lookupInfo;
  HDCloudSyncPipelineStageLookupParticipant *_lookupStage;
}

@property (readonly, copy, nonatomic) CKShareParticipant *participant;

/* instance methods */
- (id)initWithManager:(id)manager context:(id)context lookupInfo:(id)info accessibilityAssertion:(id)assertion completion:(id /* block */)completion;
- (id)pipelineForRepository:(id)repository;
@end

#endif /* HDCloudSyncManagerLookupTask_h */