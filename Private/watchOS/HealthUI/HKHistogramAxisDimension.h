//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKHistogramAxisDimension_h
#define HKHistogramAxisDimension_h
@import Foundation;

#include "HKAxisLabelDimension-Protocol.h"
#include "HKHistogramAxisDimensionDataSource-Protocol.h"

@interface HKHistogramAxisDimension : NSObject<HKAxisLabelDimension>

@property (weak, nonatomic) NSObject<HKHistogramAxisDimensionDataSource> *dataSource;

/* instance methods */
- (double)niceStepSizeLargerThan:(double)than;
- (double)ticksPerStepSize:(double)size;
- (id)formatterForLabelStepSize:(double)size;
- (id)endingLabelsFactorOverride;
- (id)stringForLocation:(id)location formatterForStepSize:(id)size;
@end

#endif /* HKHistogramAxisDimension_h */