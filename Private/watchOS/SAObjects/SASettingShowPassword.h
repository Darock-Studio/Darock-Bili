//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3300.28.1.0.0
//
#ifndef SASettingShowPassword_h
#define SASettingShowPassword_h
@import Foundation;

#include "SASettingCommand.h"

@class NSNumber, NSString;

@interface SASettingShowPassword : SASettingCommand

@property (copy, nonatomic) NSString *appBundleId;
@property (copy, nonatomic) NSString *appOrWebsiteName;
@property (copy, nonatomic) NSNumber *shouldPromptForAuthentication;
@property (copy, nonatomic) NSString *spokenAppOrWebsiteName;

/* class methods */
+ (id)showPassword;
+ (id)showPasswordWithDictionary:(id)dictionary context:(id)context;

/* instance methods */
- (id)groupIdentifier;
- (id)encodedClassName;
- (BOOL)requiresResponse;
@end

#endif /* SASettingShowPassword_h */