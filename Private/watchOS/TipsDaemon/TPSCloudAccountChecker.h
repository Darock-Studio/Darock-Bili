//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 720.1.0.0.0
//
#ifndef TPSCloudAccountChecker_h
#define TPSCloudAccountChecker_h
@import Foundation;

@interface TPSCloudAccountChecker : NSObject
/* class methods */
+ (BOOL)isiCloudAccountEnabled;
+ (BOOL)isiCloudDataClassEnabled:(id)enabled;
+ (id)_primaryCloudAccount;
@end

#endif /* TPSCloudAccountChecker_h */