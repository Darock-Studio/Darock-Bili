//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.3.1.0.0
//
#ifndef KVPriorInfo_h
#define KVPriorInfo_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@interface KVPriorInfo : NSObject<NSSecureCoding, NSCopying> {
  /* instance variables */
  unsigned int _ordinality;
  float _score;
}

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithOrdinality:(unsigned int)ordinality score:(float)score;
- (id)init;
- (unsigned int)ordinality;
- (float)score;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)description;
- (BOOL)isEqual:(id)equal;
- (BOOL)isEqualToPriorInfo:(id)info;
- (unsigned long long)hash;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
@end

#endif /* KVPriorInfo_h */