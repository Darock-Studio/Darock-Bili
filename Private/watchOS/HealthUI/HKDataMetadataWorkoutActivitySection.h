//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKDataMetadataWorkoutActivitySection_h
#define HKDataMetadataWorkoutActivitySection_h
@import Foundation;

#include "HKDataMetadataSection.h"
#include "HKDisplayTypeController.h"
#include "HKUnitPreferenceController.h"
#include "HKWorkoutDurationNumberFormatter.h"

@class HKWorkout, NSDateComponentsFormatter;

@interface HKDataMetadataWorkoutActivitySection : HKDataMetadataSection

@property (retain, nonatomic) HKWorkout *workout;
@property (retain, nonatomic) NSDateComponentsFormatter *dateFormatter;
@property (retain, nonatomic) HKWorkoutDurationNumberFormatter *durationFormatter;
@property (retain, nonatomic) HKDisplayTypeController *displayTypeController;
@property (retain, nonatomic) HKUnitPreferenceController *unitPreferenceController;

/* instance methods */
- (id)initWithSample:(id)sample displayTypeController:(id)controller unitController:(id)controller;
- (id)sectionTitle;
- (unsigned long long)numberOfRowsInSection;
- (id)cellForIndex:(unsigned long long)index tableView:(id)view;
- (void)selectCellForIndex:(unsigned long long)index navigationController:(id)controller animated:(BOOL)animated;
@end

#endif /* HKDataMetadataWorkoutActivitySection_h */