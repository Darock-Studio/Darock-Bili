//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 236.12.0.0.0
//
#ifndef SHCampaignTokens_h
#define SHCampaignTokens_h
@import Foundation;

@class NSDictionary;

@interface SHCampaignTokens : NSObject

@property (readonly, nonatomic) NSDictionary *campaignTokens;

/* instance methods */
- (id)initWithConfiguration:(id)configuration;
- (id)tokenForClientIdentifier:(id)identifier;
@end

#endif /* SHCampaignTokens_h */