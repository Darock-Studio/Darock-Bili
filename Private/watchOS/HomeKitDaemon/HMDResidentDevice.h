//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDResidentDevice_h
#define HMDResidentDevice_h
@import Foundation;

#include "HMFObject.h"
#include "HMDBackingStoreObjectProtocol-Protocol.h"
#include "HMDDevice.h"
#include "HMDDeviceAddress.h"
#include "HMDDeviceController.h"
#include "HMDDeviceControllerDelegate-Protocol.h"
#include "HMDHome.h"
#include "HMDResidentDeviceManager-Protocol.h"
#include "HMFDumpState-Protocol.h"
#include "HMFLogging-Protocol.h"
#include "HMResidentCapabilities-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class HMResidentCapabilities, NSData, NSString, NSUUID;

@interface HMDResidentDevice : HMFObject<HMDDeviceControllerDelegate, HMDBackingStoreObjectProtocol, HMFDumpState, HMFLogging, NSSecureCoding> {
  /* instance variables */
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _lock;
  HMDDeviceController *_deviceController;
}

@property (readonly, nonatomic) unsigned long long status;
@property (readonly) NSData *rawCapabilities;
@property (readonly) HMResidentCapabilities *capabilitiesInternal;
@property (copy, nonatomic) NSUUID *identifier;
@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL reachable;
@property (nonatomic) BOOL reachableByIDS;
@property (nonatomic) long long batteryState;
@property (nonatomic) BOOL lowBattery;
@property (weak, nonatomic) HMDHome *home;
@property (weak, nonatomic) NSObject<HMDResidentDeviceManager> *residentDeviceManager;
@property (readonly, nonatomic) unsigned long long legacyResidentCapabilities;
@property (readonly) BOOL currentDevice;
@property (readonly, nonatomic) HMDDevice *device;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) BOOL confirmed;
@property (readonly, nonatomic) BOOL supportsSharedEventTriggerActivation;
@property (readonly, nonatomic) BOOL supportsMediaSystem;
@property (readonly, nonatomic) BOOL supportsMediaActions;
@property (readonly, nonatomic) BOOL supportsShortcutActions;
@property (readonly, nonatomic) BOOL supportsFirmwareUpdate;
@property (readonly, nonatomic) BOOL supportsResidentFirmwareUpdate;
@property (readonly, nonatomic) BOOL supportsCustomMediaApplicationDestination;
@property (readonly, nonatomic) NSObject<HMResidentCapabilities> *capabilities;
@property (readonly) HMDDeviceAddress *messageAddress;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)shortDescription;
+ (id)batteryStateAsString:(long long)string;
+ (id)logCategory;
+ (BOOL)supportsSecureCoding;
+ (id)deriveUUIDFromHomeUUID:(id)uuid deviceUUID:(id)uuid;

/* instance methods */
- (id)init;
- (id)initWithModel:(id)model;
- (id)initWithDevice:(id)device identifier:(id)identifier;
- (id)initWithDevice:(id)device home:(id)home;
- (id)initWithDevice:(id)device home:(id)home name:(id)name rawCapabilities:(id)capabilities messageAddress:(id)address;
- (id)initWithDeviceController:(id)controller identifier:(id)identifier;
- (void)dealloc;
- (void)configureWithHome:(id)home;
- (id)shortDescription;
- (id)descriptionWithPointer:(BOOL)pointer;
- (id)privateDescription;
- (BOOL)isEqual:(id)equal;
- (BOOL)isDeviceEquivalentToDeviceAddress:(id)address;
- (BOOL)isConfirmed;
- (id)runtimeState;
- (BOOL)isCurrentDevice;
- (id)deviceController;
- (void)__deviceUpdated:(id)updated;
- (void)transactionObjectUpdated:(id)updated newValues:(id)values message:(id)message;
- (void)transactionObjectRemoved:(id)removed message:(id)message;
- (void)_residentDeviceModelUpdated:(id)updated newValues:(id)values message:(id)message;
- (void)_handleResidentDeviceUpdateEnabled:(BOOL)enabled;
- (void)_handleResidentDeviceUpdateConfirmed:(BOOL)confirmed;
- (id)modelObjectWithChangeType:(unsigned long long)type version:(long long)version;
- (BOOL)_updateRawCapabilities:(id)capabilities;
- (BOOL)_updateMessageAddress:(id)address;
- (void)deviceController:(id)controller didUpdateDevice:(id)device;
- (id)dumpState;
- (id)logIdentifier;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (BOOL)isEnabled;
- (BOOL)isReachable;
- (BOOL)isReachableByIDS;
- (BOOL)isLowBattery;
@end

#endif /* HMDResidentDevice_h */