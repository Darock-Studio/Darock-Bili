//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef _MKFLocationEvent_h
#define _MKFLocationEvent_h
@import Foundation;

#include "_MKFEvent.h"
#include "HMDNSManagedObjectBackingStoreModelObjectRepresentable-Protocol.h"
#include "MKFEventTrigger-Protocol.h"
#include "MKFHome-Protocol.h"
#include "MKFLocationEvent-Protocol.h"
#include "MKFLocationEventDatabaseID.h"
#include "MKFLocationEventPrivateExtensions-Protocol.h"
#include "MKFUser-Protocol.h"

@class CLRegion, NSDate, NSNumber, NSString, NSUUID;

@interface _MKFLocationEvent : _MKFEvent<HMDNSManagedObjectBackingStoreModelObjectRepresentable, MKFLocationEvent, MKFLocationEventPrivateExtensions>

@property (readonly, copy, nonatomic) NSUUID *hmd_modelID;
@property (readonly, copy, nonatomic) NSUUID *hmd_parentModelID;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (retain, @dynamic, nonatomic) CLRegion *region;
@property (retain, @dynamic, nonatomic) _MKFUser *user;
@property (retain, @dynamic, nonatomic) CLRegion *region;
@property (retain, @dynamic, nonatomic) NSObject<MKFUser> *user;
@property (readonly, copy, nonatomic) MKFLocationEventDatabaseID *databaseID;
@property (readonly) NSObject<MKFHome> *home;
@property (copy, nonatomic) NSNumber *endEvent;
@property (copy, nonatomic) NSDate *writerTimestamp;
@property (readonly, retain, nonatomic) NSObject<MKFEventTrigger> *trigger;
@property (readonly, copy, nonatomic) NSUUID *modelID;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)fetchRequest;
+ (Class)cd_modelClass;
+ (id)modelIDForParentRelationshipTo:(id)to;
+ (id)backingModelProtocol;

/* instance methods */
- (id)castIfLocationEvent;
- (BOOL)synchronizeUserRelationWith:(id)with;
- (void)addUserObject:(id)object;
- (void)removeUserObject:(id)object;
@end

#endif /* _MKFLocationEvent_h */