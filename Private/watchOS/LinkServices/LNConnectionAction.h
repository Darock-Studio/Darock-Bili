//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 146.60.7.1.1
//
#ifndef LNConnectionAction_h
#define LNConnectionAction_h
@import Foundation;

#include "BSXPCSecureCoding-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSString, NSUUID;

@interface LNConnectionAction : NSObject<BSXPCSecureCoding, NSSecureCoding>

@property (readonly, nonatomic) NSUUID *identifier;
@property (readonly, nonatomic) long long metadataVersion;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)supportsSecureCoding;
+ (BOOL)supportsBSXPCSecureCoding;

/* instance methods */
- (id)initWithIdentifier:(id)identifier metadataVersion:(long long)version;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
- (void)encodeWithBSXPCCoder:(id)bsxpccoder;
- (id)initWithBSXPCCoder:(id)bsxpccoder;
@end

#endif /* LNConnectionAction_h */