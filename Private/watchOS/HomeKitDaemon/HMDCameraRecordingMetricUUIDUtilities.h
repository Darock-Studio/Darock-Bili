//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDCameraRecordingMetricUUIDUtilities_h
#define HMDCameraRecordingMetricUUIDUtilities_h
@import Foundation;

#include "HMFObject.h"

@interface HMDCameraRecordingMetricUUIDUtilities : HMFObject
/* class methods */
+ (id)UUIDRotationSalt;
+ (id)ephemeralUUIDWithUUID:(id)uuid forTimestamp:(unsigned long long)timestamp rotationSchedule:(unsigned long long)schedule;
+ (id)currentEphemeralUUIDWithUUID:(id)uuid rotationScheduleDays:(unsigned long long)days;
+ (id)ephemeralUUIDWithUUID:(id)uuid forTimestamp:(unsigned long long)timestamp rotationScheduleDays:(unsigned long long)days;
@end

#endif /* HMDCameraRecordingMetricUUIDUtilities_h */