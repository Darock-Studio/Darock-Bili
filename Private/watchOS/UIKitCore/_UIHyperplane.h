//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIHyperplane_h
#define _UIHyperplane_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"
#include "_UIHyperregion_Internal-Protocol.h"

@class NSString;

@interface _UIHyperplane : NSObject<_UIHyperregion_Internal, NSSecureCoding, NSCopying>

@property (readonly, nonatomic) const double * _point;
@property (readonly, nonatomic) const double * _normal;
@property (readonly, nonatomic) unsigned long long _dimensions;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)supportsSecureCoding;
+ (id)keyPathsForValuesAffectingSelf;

/* instance methods */
- (id)initWithDimensions:(unsigned long long)dimensions;
- (void)dealloc;
- (void)_mutatePoint:(id /* block */)point;
- (void)_mutateNormal:(id /* block */)normal;
- (void)_closestPoint:(double *)point toPoint:(const double *)point;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
@end

#endif /* _UIHyperplane_h */