//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2220.14.1.0.0
//
#ifndef AVVideoCompositionInstruction_h
#define AVVideoCompositionInstruction_h
@import Foundation;

#include "AVVideoCompositionInstruction-Protocol.h"
#include "AVVideoCompositionInstructionInternal.h"
#include "NSCopying-Protocol.h"
#include "NSMutableCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSArray, NSString;

@interface AVVideoCompositionInstruction : NSObject<NSSecureCoding, NSCopying, NSMutableCopying, AVVideoCompositionInstruction> {
  /* instance variables */
  AVVideoCompositionInstructionInternal *_instruction;
}

@property (readonly, nonatomic) struct { struct { long long x0; int x1; unsigned int x2; long long x3; } x0; struct { long long x0; int x1; unsigned int x2; long long x3; } x1; } timeRange;
@property (readonly, retain, nonatomic) struct CGColor * backgroundColor;
@property (readonly, copy, nonatomic) NSArray *layerInstructions;
@property (readonly, nonatomic) BOOL enablePostProcessing;
@property (readonly, nonatomic) NSArray *requiredSourceTrackIDs;
@property (readonly, nonatomic) int passthroughTrackID;
@property (readonly, nonatomic) NSArray *requiredSourceSampleDataTrackIDs;
@property (readonly, nonatomic) BOOL containsTweening;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (void)initialize;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)init;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (BOOL)isEqual:(id)equal;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)mutableCopyWithZone:(struct _NSZone *)zone;
- (id)_deepCopy;
- (void)dealloc;
- (id)blendingTransferFunction;
- (void)setBlendingTransferFunction:(id)function;
- (id)dictionaryRepresentation;
- (void)_setValuesFromDictionary:(id)dictionary;
@end

#endif /* AVVideoCompositionInstruction_h */