//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2298.42.9.28.5
//
#ifndef MNStringLocalizationProvider_h
#define MNStringLocalizationProvider_h
@import Foundation;

#include "GEOComposedStringLocalizationProvider-Protocol.h"

@class NSLocale, NSString;

@interface MNStringLocalizationProvider : NSObject<GEOComposedStringLocalizationProvider> {
  /* instance variables */
  NSLocale *_locale;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (void)initLocalizationProvider;

/* instance methods */
- (id)init;
- (id)locale;
- (id)spokenLocale;
- (id)aboutNDistance;
- (id)distanceAndAHalfKilometers;
- (id)aboutDistanceAndAHalfKilometers;
- (id)distanceAndAHalfMiles;
- (id)aboutDistanceAndAHalfMiles;
- (id)distanceAQuarterMile;
- (id)distanceHalfAMile;
- (id)distanceThreeQuartersOfAMile;
- (id)frequencySingleValue_OneHour;
- (id)frequencySingleValue_OneMinute;
- (id)frequencyRange_BothOnlyHours;
- (id)frequencyRange_BothOnlyMinutes;
- (id)frequencyRange_MixedUnits;
- (id)separatorForTimestampList;
- (id)minutesFormatForCountdownList;
@end

#endif /* MNStringLocalizationProvider_h */