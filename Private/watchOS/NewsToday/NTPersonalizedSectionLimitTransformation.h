//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.0.0.0.0
//
#ifndef NTPersonalizedSectionLimitTransformation_h
#define NTPersonalizedSectionLimitTransformation_h
@import Foundation;

#include "FCFeedTransforming-Protocol.h"

@class NSOrderedSet, NSString;

@interface NTPersonalizedSectionLimitTransformation : NSObject<FCFeedTransforming>

@property (copy, nonatomic) NSOrderedSet *mandatoryArticleIDs;
@property (copy, nonatomic) NSOrderedSet *personalizedArticleIDs;
@property (nonatomic) unsigned long long limit;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)init;
- (id)initWithMandatoryArticleIDs:(id)ids personalizedArticleIDs:(id)ids limit:(unsigned long long)limit;
- (id)transformFeedItems:(id)items;
@end

#endif /* NTPersonalizedSectionLimitTransformation_h */