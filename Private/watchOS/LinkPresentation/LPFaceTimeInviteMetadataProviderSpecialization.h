//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 240.3.4.0.0
//
#ifndef LPFaceTimeInviteMetadataProviderSpecialization_h
#define LPFaceTimeInviteMetadataProviderSpecialization_h
@import Foundation;

#include "LPMetadataProviderSpecialization.h"

@interface LPFaceTimeInviteMetadataProviderSpecialization : LPMetadataProviderSpecialization
/* class methods */
+ (unsigned long long)specialization;
+ (id)specializedMetadataProviderForURLWithContext:(id)context;

/* instance methods */
- (void)start;
- (void)completeWithMetadata:(id)metadata;
@end

#endif /* LPFaceTimeInviteMetadataProviderSpecialization_h */