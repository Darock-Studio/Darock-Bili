//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef CKSnapshotCacheKey_h
#define CKSnapshotCacheKey_h
@import Foundation;

#include "NSCopying-Protocol.h"

@class NSString;

@interface CKSnapshotCacheKey : NSObject<NSCopying>

@property (retain, nonatomic) NSString *identifier;
@property (nonatomic) long long interfaceStyle;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } bounds;
@property (readonly, nonatomic) NSString *stringValue;

/* class methods */
+ (id)keyWithIdentifier:(id)identifier interfaceStyle:(long long)style bounds:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })bounds;

/* instance methods */
- (id)initWithIdentifier:(id)identifier interfaceStyle:(long long)style bounds:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })bounds;
- (id)keyWithOppositeInterfaceStyle;
- (id)copyWithZone:(struct _NSZone *)zone;
- (BOOL)isEqual:(id)equal;
@end

#endif /* CKSnapshotCacheKey_h */