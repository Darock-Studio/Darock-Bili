//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKHorizontalSingleLineDataSource_h
#define HKHorizontalSingleLineDataSource_h
@import Foundation;

#include "HKHealthQueryChartCacheDataSource.h"

@class HKSampleType;

@interface HKHorizontalSingleLineDataSource : HKHealthQueryChartCacheDataSource

@property (retain, nonatomic) HKSampleType *sampleType;
@property (copy, nonatomic) id /* block */ userInfoCreationBlock;

/* instance methods */
- (id)queryDescription;
- (id)queriesForRequest:(id)request completionHandler:(id /* block */)handler;
- (id)_chartPointsWithSamples:(id)samples blockStart:(id)start blockEnd:(id)end sourceTimeZone:(id)zone;
- (void)applyMarkStyleToPoint:(id)point sample:(id)sample;
- (BOOL)supportsChartQueryDataGeneration;
- (id /* block */)generateSharableQueryDataForRequest:(id)request healthStore:(id)store completionHandler:(id /* block */)handler;
- (id)chartPointsFromQueryData:(id)data dataIsFromRemoteSource:(BOOL)source;
@end

#endif /* HKHorizontalSingleLineDataSource_h */