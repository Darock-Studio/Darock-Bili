//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 651.5.0.0.0
//
#ifndef BSXPCCodingArray_h
#define BSXPCCodingArray_h
@import Foundation;

#include "BSDescriptionProviding-Protocol.h"
#include "BSXPCCoding-Protocol.h"
#include "NSFastEnumeration-Protocol.h"

@class NSArray, NSString;

@interface BSXPCCodingArray : NSObject<NSFastEnumeration, BSXPCCoding, BSDescriptionProviding> {
  /* instance variables */
  NSArray *_array;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithArray:(id)array;
- (unsigned long long)count;
- (id)array;
- (unsigned long long)countByEnumeratingWithState:(struct { unsigned long long x0; id * x1; unsigned long long * x2; unsigned long long x3[5] } *)state objects:(id *)objects count:(unsigned long long)count;
- (id)initWithXPCDictionary:(id)xpcdictionary;
- (void)encodeWithXPCDictionary:(id)xpcdictionary;
- (id)succinctDescription;
- (id)succinctDescriptionBuilder;
- (id)descriptionWithMultilinePrefix:(id)prefix;
- (id)descriptionBuilderWithMultilinePrefix:(id)prefix;
@end

#endif /* BSXPCCodingArray_h */