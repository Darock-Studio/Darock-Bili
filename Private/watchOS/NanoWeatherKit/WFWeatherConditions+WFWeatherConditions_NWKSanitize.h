//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 949.0.0.0.0
//
#ifndef WFWeatherConditions_WFWeatherConditions_NWKSanitize_h
#define WFWeatherConditions_WFWeatherConditions_NWKSanitize_h
@import Foundation;

@interface WFWeatherConditions (WFWeatherConditions_NWKSanitize)
/* class methods */
+ (id)nwm_localizedWindpeedUnit;
+ (id)_defaultWindSpeedWithUnit:(double)unit;
+ (id)_localizedWindspeed:(double)windspeed withUnit:(int)unit forLocale:(id)locale;
+ (int)_preferredWindSpeedUnitForLocale:(id)locale;
+ (id)nwk_chanceOfPrecipitationSummary:(id)summary;
+ (id)nwm_localizedDescriptionForConditionCode:(unsigned long long)code timeOfDay:(unsigned long long)day;
+ (id)nwm_localizedDescriptionShortForConditionCode:(unsigned long long)code timeOfDay:(unsigned long long)day;
+ (id)nwm_localizedDescriptionKeyForConditionCode:(unsigned long long)code timeOfDay:(unsigned long long)day;
+ (id)nwm_localizedDescriptionShortKeyForConditionCode:(unsigned long long)code timeOfDay:(unsigned long long)day;
+ (id)nwm_localizedNoData;
+ (id)nwm_localizedNoDataRounded;
+ (id)_nwm_shortSuffixedKey:(id)key;

/* instance methods */
- (BOOL)isCodeInGroup:(unsigned long long *)group size:(unsigned long long)size;
- (unsigned long long)conditionType;
- (BOOL)appliesToDate:(id)date withinInterval:(double)interval;
- (id)nwm_localizedWindDirectionAbbreviation;
- (id)nwm_localizedWindDirectionAbbreviationCompact;
- (id)nwm_localizedWindDirection;
- (id)nwm_localizedWindspeedWithUnit;
- (id)nwm_localizedWindspeedWithoutUnit;
- (id)nwm_windDirectionKey;
- (unsigned long long)_indexOfWindDirectionKeyForWindDirectionInDegrees:(double)degrees keys:(id)keys;
- (id)_localizedWindDirectionAbbreviation:(BOOL)abbreviation;
- (double)_speedByConverting:(double)converting toUnit:(int)unit;
- (id)nwm_localizedUltravioletIndexRiskDescription;
- (unsigned long long)nwm_ultravioletIndexCategory;
- (id)nwkLocalizedFormattedHighTemperature;
- (id)nwkLocalizedFormattedLowTemperature;
- (id)nwkLocalizedFormattedHighLowTemperatures;
- (id)nwkLocalizedFormattedCondensedHighLowTemperatures;
- (id)_nwkFormattedHighLowTemperaturesWithFormat:(id)format;
- (id)nwkLocalizedDescriptionShort;
- (id)nwkLocalizedDescription;
- (id)date;
- (id)expirationDate;
- (double)duration;
- (id)sunriseDate;
- (id)sunsetDate;
- (id)temperature;
- (id)temperatureHigh;
- (id)temperatureLow;
- (unsigned long long)conditionCode;
- (id)nwkUVIndex;
- (id)nwk_UVIndex;
- (id)nwk_localizedFormattedUVIndex;
- (unsigned long long)nwk_UVIndexCategory;
- (id)nwk_UVIndexRiskDescription;
- (id)nwk_localizedWindspeedWithUnit;
- (id)nwk_localizedWindspeedWithoutUnit;
- (float)nwk_windDirectionInDegrees;
- (id)nwk_windLocalizedDirectionAbbreviation;
- (id)nwk_windCompactLocalizedDirectionAbbreviation;
- (BOOL)nwk_wf_isDay;
- (id)nwkLocalizedFormattedUVIndex;
- (unsigned long long)nwkUVIndexCategory;
- (id)nwkLocalizedWindspeedWithoutUnit;
- (float)windDirectionInDegrees;
- (id)nwk_smallConditionImageForTimeOfDay:(unsigned long long)day;
- (id)nwk_largeConditionImageForTimeOfDay:(unsigned long long)day;
- (id)_nwkConditionImage:(unsigned long long)image forceDaytime:(BOOL)daytime;
- (id)nwkSmallConditionImage;
- (id)nwkSmallConditionDaytimeImage;
- (id)nwkLargeConditionImage;
- (id)nwm_localizedDescriptionForTimeOfDay:(unsigned long long)day;
- (id)nwm_localizedDescriptionShortForTimeOfDay:(unsigned long long)day;
- (id)nwm_localizedDescriptionKeyForTimeOfDay:(unsigned long long)day;
- (id)nwm_localizedDescription;
- (id)nwm_localizedDescriptionKey;
- (id)nwm_localizedDescriptionShort;
- (unsigned long long)nw_timeOfDay;
- (void)nwk_ensureFutureExpirationDate;
@end

#endif /* WFWeatherConditions_WFWeatherConditions_NWKSanitize_h */