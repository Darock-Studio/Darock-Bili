//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKChartAxisDimensionUsingTable_h
#define HKChartAxisDimensionUsingTable_h
@import Foundation;

#include "HKAxisLabelDimension-Protocol.h"
#include "HKDisplayType.h"
#include "HKUnitPreferenceController.h"

@interface HKChartAxisDimensionUsingTable : NSObject<HKAxisLabelDimension>

@property (readonly) struct HKStepSizeTableEntryDefn { double x0; double x1; } * stepSizeTable;
@property (readonly) long long stepSizeTableSize;
@property (readonly) HKDisplayType *displayType;
@property (readonly) HKUnitPreferenceController *unitController;

/* instance methods */
- (id)initWithStepSizeTable:(struct HKStepSizeTableEntryDefn { double x0; double x1; } *)table stepSizeTableSize:(long long)size displayType:(id)type unitController:(id)controller;
- (double)niceStepSizeLargerThan:(double)than;
- (double)ticksPerStepSize:(double)size;
- (id)formatterForLabelStepSize:(double)size;
- (id)endingLabelsFactorOverride;
- (id)stringForLocation:(id)location formatterForStepSize:(id)size;
- (struct HKStepSizeTableEntryDefn { double x0; double x1; } *)_findStepSize:(double)size allowEqual:(BOOL)equal;
@end

#endif /* HKChartAxisDimensionUsingTable_h */