//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDFeatureAvailabilityOnboardingEligibilityDeterminer_h
#define HDFeatureAvailabilityOnboardingEligibilityDeterminer_h
@import Foundation;

#include "HDFeatureDisableAndExpiryProviding-Protocol.h"
#include "HDPairedDeviceCapabilityProviding-Protocol.h"
#include "HDPairedFeatureAttributesProviding-Protocol.h"
#include "HDRegionAvailabilityProviding-Protocol.h"

@class NSString, NSUUID;
@protocol OS_os_log;

@interface HDFeatureAvailabilityOnboardingEligibilityDeterminer : NSObject {
  /* instance variables */
  NSString *_featureIdentifier;
  NSUUID *_pairedDeviceCapability;
  NSObject<HDPairedDeviceCapabilityProviding> *_pairedDeviceCapabilityProvider;
  NSObject<HDPairedFeatureAttributesProviding> *_pairedFeatureAttributesProvider;
  NSObject<HDRegionAvailabilityProviding> *_regionAvailabilityProvider;
  NSObject<HDFeatureDisableAndExpiryProviding> *_disableAndExpiryProvider;
  NSObject<OS_os_log> *_loggingCategory;
}

@property (nonatomic) long long currentOnboardingVersion;

/* instance methods */
- (id)initWithFeatureIdentifier:(id)identifier currentOnboardingVersion:(long long)version pairedDeviceCapability:(id)capability pairedDeviceCapabilityProvider:(id)provider regionAvailabilityProvider:(id)provider disableAndExpiryProvider:(id)provider loggingCategory:(id)category;
- (id)description;
- (id)onboardingEligibilityForCountryCode:(id)code error:(id *)error;
- (id)onboardingEligibilityForDevice:(id)device countryCode:(id)code error:(id *)error;
- (id)_onboardingEligibilityForRegionEligibility:(id)eligibility rescindedStatus:(id)status isCapabilitySupported:(id)supported isActiveRemoteDevicePresent:(id)present;
- (id)onboardingEligibilitiesForOnboardingCompletions:(id)completions error:(id *)error;
- (id)onboardingEligibilitiesForDevice:(id)device onboardingCompletions:(id)completions error:(id *)error;
- (id)_onboardingEligibilitiesForOnboardingCompletions:(id)completions onboardingEligibilityRetrievalBlock:(id /* block */)block error:(id *)error;
- (BOOL)_isActiveRemoteDevicePresent;
@end

#endif /* HDFeatureAvailabilityOnboardingEligibilityDeterminer_h */