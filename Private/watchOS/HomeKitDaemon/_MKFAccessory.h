//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef _MKFAccessory_h
#define _MKFAccessory_h
@import Foundation;

#include "_MKFModel.h"
#include "HMDNSManagedObjectBackingStoreModelObjectRepresentable-Protocol.h"
#include "MKFAccessory-Protocol.h"
#include "MKFAccessoryDatabaseID.h"
#include "MKFAccessoryPrivateExtensions-Protocol.h"
#include "MKFApplicationData-Protocol.h"
#include "MKFHome-Protocol.h"
#include "MKFRoom-Protocol.h"
#include "MKFSoftwareUpdate-Protocol.h"

@class NSArray, NSData, NSDate, NSNumber, NSSet, NSString, NSUUID;

@interface _MKFAccessory : _MKFModel<HMDNSManagedObjectBackingStoreModelObjectRepresentable, MKFAccessory, MKFAccessoryPrivateExtensions>

@property (readonly, copy, nonatomic) NSUUID *hmd_modelID;
@property (readonly, copy, nonatomic) NSUUID *hmd_parentModelID;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;
@property (copy, @dynamic, nonatomic) NSNumber *accessoryCategory;
@property (retain, @dynamic, nonatomic) NSArray *appliedFirewallWANRules;
@property (copy, @dynamic, nonatomic) NSString *configurationAppIdentifier;
@property (copy, @dynamic, nonatomic) NSString *configuredName;
@property (copy, @dynamic, nonatomic) NSNumber *currentNetworkProtectionMode;
@property (copy, @dynamic, nonatomic) NSString *firmwareVersion;
@property (copy, @dynamic, nonatomic) NSUUID *groupIdentifier;
@property (copy, @dynamic, nonatomic) NSString *groupName;
@property (copy, @dynamic, nonatomic) NSString *identifier;
@property (copy, @dynamic, nonatomic) NSNumber *initialCategoryIdentifier;
@property (copy, @dynamic, nonatomic) NSString *initialManufacturer;
@property (copy, @dynamic, nonatomic) NSString *initialModel;
@property (copy, @dynamic, nonatomic) NSNumber *lastNetworkAccessViolationOccurrenceSince1970;
@property (copy, @dynamic, nonatomic) NSNumber *lastNetworkAccessViolationResetSince1970;
@property (copy, @dynamic, nonatomic) NSDate *lastSeenDate;
@property (copy, @dynamic, nonatomic) NSNumber *lowBattery;
@property (copy, @dynamic, nonatomic) NSString *manufacturer;
@property (copy, @dynamic, nonatomic) NSString *model;
@property (copy, @dynamic, nonatomic) NSUUID *modelID;
@property (copy, @dynamic, nonatomic) NSNumber *networkClientIdentifier;
@property (copy, @dynamic, nonatomic) NSNumber *networkClientLAN;
@property (copy, @dynamic, nonatomic) NSString *networkClientProfileFingerprint;
@property (copy, @dynamic, nonatomic) NSString *networkRouterUUID;
@property (copy, @dynamic, nonatomic) NSString *pendingConfigurationIdentifier;
@property (copy, @dynamic, nonatomic) NSString *primaryProfileVersion;
@property (copy, @dynamic, nonatomic) NSString *productData;
@property (copy, @dynamic, nonatomic) NSString *providedName;
@property (copy, @dynamic, nonatomic) NSString *serialNumber;
@property (copy, @dynamic, nonatomic) NSNumber *suspendCapable;
@property (copy, @dynamic, nonatomic) NSNumber *wiFiCredentialType;
@property (retain, @dynamic, nonatomic) NSData *wiFiUniquePreSharedKey;
@property (copy, @dynamic, nonatomic) NSDate *writerTimestamp;
@property (retain, @dynamic, nonatomic) NSSet *actionMediaPlaybacks_;
@property (retain, @dynamic, nonatomic) NSSet *analysisEventBulletinRegistrations_;
@property (retain, @dynamic, nonatomic) _MKFApplicationData *applicationData;
@property (retain, @dynamic, nonatomic) NSSet *cameraAccessModeBulletinRegistrations_;
@property (retain, @dynamic, nonatomic) NSSet *cameraReachabilityBulletinRegistrations_;
@property (retain, @dynamic, nonatomic) NSSet *cameraSignificantEventBulletinRegistrations_;
@property (retain, @dynamic, nonatomic) _MKFHome *home;
@property (retain, @dynamic, nonatomic) _MKFAccessory *hostAccessory;
@property (retain, @dynamic, nonatomic) NSSet *hostedAccessories_;
@property (retain, @dynamic, nonatomic) NSSet *mediaPropertyNotificationRegistrations_;
@property (retain, @dynamic, nonatomic) _MKFRoom *room;
@property (retain, @dynamic, nonatomic) _MKFSoftwareUpdate *softwareUpdate;
@property (retain, @dynamic, nonatomic) NSSet *usersWithListeningHistoryEnabled_;
@property (retain, @dynamic, nonatomic) NSSet *usersWithMediaContentProfileEnabled_;
@property (retain, @dynamic, nonatomic) NSSet *usersWithPersonalRequestsEnabled_;
@property (copy, @dynamic, nonatomic) NSNumber *accessoryCategory;
@property (retain, @dynamic, nonatomic) NSArray *appliedFirewallWANRules;
@property (copy, @dynamic, nonatomic) NSString *configurationAppIdentifier;
@property (copy, @dynamic, nonatomic) NSString *configuredName;
@property (copy, @dynamic, nonatomic) NSNumber *currentNetworkProtectionMode;
@property (copy, @dynamic, nonatomic) NSString *firmwareVersion;
@property (copy, @dynamic, nonatomic) NSUUID *groupIdentifier;
@property (copy, @dynamic, nonatomic) NSString *groupName;
@property (copy, @dynamic, nonatomic) NSString *identifier;
@property (copy, @dynamic, nonatomic) NSNumber *initialCategoryIdentifier;
@property (copy, @dynamic, nonatomic) NSString *initialManufacturer;
@property (copy, @dynamic, nonatomic) NSString *initialModel;
@property (copy, @dynamic, nonatomic) NSNumber *lastNetworkAccessViolationOccurrenceSince1970;
@property (copy, @dynamic, nonatomic) NSNumber *lastNetworkAccessViolationResetSince1970;
@property (copy, @dynamic, nonatomic) NSDate *lastSeenDate;
@property (copy, @dynamic, nonatomic) NSNumber *lowBattery;
@property (copy, @dynamic, nonatomic) NSString *manufacturer;
@property (copy, @dynamic, nonatomic) NSString *model;
@property (copy, @dynamic, nonatomic) NSNumber *networkClientIdentifier;
@property (copy, @dynamic, nonatomic) NSNumber *networkClientLAN;
@property (copy, @dynamic, nonatomic) NSString *networkClientProfileFingerprint;
@property (copy, @dynamic, nonatomic) NSString *networkRouterUUID;
@property (copy, @dynamic, nonatomic) NSString *pendingConfigurationIdentifier;
@property (copy, @dynamic, nonatomic) NSString *primaryProfileVersion;
@property (copy, @dynamic, nonatomic) NSString *productData;
@property (copy, @dynamic, nonatomic) NSString *providedName;
@property (copy, @dynamic, nonatomic) NSString *serialNumber;
@property (copy, @dynamic, nonatomic) NSNumber *suspendCapable;
@property (copy, @dynamic, nonatomic) NSNumber *wiFiCredentialType;
@property (retain, @dynamic, nonatomic) NSData *wiFiUniquePreSharedKey;
@property (copy, @dynamic, nonatomic) NSDate *writerTimestamp;
@property (readonly, retain, nonatomic) NSArray *actionMediaPlaybacks;
@property (readonly, retain, nonatomic) NSArray *analysisEventBulletinRegistrations;
@property (retain, @dynamic, nonatomic) NSObject<MKFApplicationData> *applicationData;
@property (readonly, retain, nonatomic) NSArray *cameraAccessModeBulletinRegistrations;
@property (readonly, retain, nonatomic) NSArray *cameraReachabilityBulletinRegistrations;
@property (readonly, retain, nonatomic) NSArray *cameraSignificantEventBulletinRegistrations;
@property (readonly, retain, @dynamic, nonatomic) NSObject<MKFHome> *home;
@property (retain, @dynamic, nonatomic) NSObject<MKFAccessory> *hostAccessory;
@property (readonly, retain, nonatomic) NSArray *hostedAccessories;
@property (readonly, retain, nonatomic) NSArray *mediaPropertyNotificationRegistrations;
@property (retain, @dynamic, nonatomic) NSObject<MKFRoom> *room;
@property (retain, @dynamic, nonatomic) NSObject<MKFSoftwareUpdate> *softwareUpdate;
@property (readonly, retain, nonatomic) NSArray *usersWithListeningHistoryEnabled;
@property (readonly, retain, nonatomic) NSArray *usersWithMediaContentProfileEnabled;
@property (readonly, retain, nonatomic) NSArray *usersWithPersonalRequestsEnabled;
@property (readonly, copy, nonatomic) MKFAccessoryDatabaseID *databaseID;
@property (readonly, copy, @dynamic, nonatomic) NSUUID *modelID;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)fetchRequest;
+ (Class)cd_modelClass;
+ (id)modelIDForParentRelationshipTo:(id)to;
+ (id)homeRelation;
+ (id)backingModelProtocol;

/* instance methods */
- (BOOL)isSecureClassAccessory;
- (id)castIfAccessory;
- (id)materializeOrCreateApplicationDataRelation:(BOOL *)relation;
- (void)addHostedAccessoriesObject:(id)object;
- (void)removeHostedAccessoriesObject:(id)object;
- (id)materializeOrCreateSoftwareUpdateRelation:(BOOL *)relation;
- (void)addUsersWithListeningHistoryEnabledObject:(id)object;
- (void)removeUsersWithListeningHistoryEnabledObject:(id)object;
- (void)addUsersWithMediaContentProfileEnabledObject:(id)object;
- (void)removeUsersWithMediaContentProfileEnabledObject:(id)object;
- (void)addUsersWithPersonalRequestsEnabledObject:(id)object;
- (void)removeUsersWithPersonalRequestsEnabledObject:(id)object;
@end

#endif /* _MKFAccessory_h */