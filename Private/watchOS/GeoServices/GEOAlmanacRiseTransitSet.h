//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOAlmanacRiseTransitSet_h
#define GEOAlmanacRiseTransitSet_h
@import Foundation;

@class NSDate;

@interface GEOAlmanacRiseTransitSet : NSObject

@property (readonly, nonatomic) NSDate *rise;
@property (readonly, nonatomic) NSDate *transit;
@property (readonly, nonatomic) NSDate *set;
@property (readonly, nonatomic) BOOL isIdeal;
@property (readonly, nonatomic) struct _GEORiseTransitSetEvent { double x0; unsigned int x1; } firstItem;
@property (readonly, nonatomic) struct _GEORiseTransitSetEvent { double x0; unsigned int x1; } lastItem;

/* instance methods */
- (id)initWithRise:(const struct _GEORiseTransitSetEvent { double x0; unsigned int x1; } *)rise transit:(const struct _GEORiseTransitSetEvent { double x0; unsigned int x1; } *)transit set:(const struct _GEORiseTransitSetEvent { double x0; unsigned int x1; } *)set;
- (id)description;
@end

#endif /* GEOAlmanacRiseTransitSet_h */