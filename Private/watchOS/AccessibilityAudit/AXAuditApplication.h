//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 149.1.0.0.0
//
#ifndef AXAuditApplication_h
#define AXAuditApplication_h
@import Foundation;

#include "AXAuditPSN.h"

@class NSString, UIImage;

@interface AXAuditApplication : NSObject

@property (retain, nonatomic) AXAuditPSN *psnObj;
@property (nonatomic) int pid;
@property (copy, nonatomic) NSString *displayName;
@property (copy, nonatomic) NSString *bundleIdentifier;
@property (retain, nonatomic) UIImage *icon;

/* class methods */
+ (void)registerTransportableObjectWithManager:(id)manager;

/* instance methods */
- (id)copyWithZone:(struct _NSZone *)zone;
- (unsigned long long)hash;
- (BOOL)isEqual:(id)equal;
@end

#endif /* AXAuditApplication_h */