//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDMediaPlaybackActionAsCharacteristicWriteRequests_h
#define HMDMediaPlaybackActionAsCharacteristicWriteRequests_h
@import Foundation;

#include "HMFObject.h"
#include "HMDMediaPlaybackAction.h"

@class NSArray;

@interface HMDMediaPlaybackActionAsCharacteristicWriteRequests : HMFObject

@property (readonly) HMDMediaPlaybackAction *residualAction;
@property (readonly) NSArray *characteristicWriteRequests;

/* instance methods */
- (id)init;
- (id)initWithAction:(id)action characteristicWriteRequests:(id)requests;
@end

#endif /* HMDMediaPlaybackActionAsCharacteristicWriteRequests_h */