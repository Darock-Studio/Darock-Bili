//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3431.206.0.0.0
//
#ifndef TIUserModel_h
#define TIUserModel_h
@import Foundation;

#include "TIMetricProviding-Protocol.h"
#include "TIUserModelDataStoring-Protocol.h"
#include "TIUserModeling-Protocol.h"

@class NSArray, NSDate, NSDictionary, NSMutableDictionary, NSString;
@protocol TIUserModelConfigurationDelegate;

@interface TIUserModel : NSObject<TIUserModeling, TIMetricProviding> {
  /* instance variables */
  NSObject<TIUserModelDataStoring> *_userModelStore;
  NSMutableDictionary *_durableCounters;
  NSMutableDictionary *_userModelValuesCollection;
  NSDictionary *_settingsDictionary;
  double _timeOfLastPersist;
}

@property (retain, nonatomic) NSDate *loadedDate;
@property BOOL userModelRateLimitingDisabled;
@property (readonly, nonatomic) NSString *inputMode;
@property (copy, nonatomic) NSArray *weeklyMetricKeys;
@property (readonly, nonatomic) NSDate *fromDate;
@property (readonly) BOOL explicitTearDown;
@property (weak, nonatomic) NSObject<TIUserModelConfigurationDelegate> *configurationDelegate;
@property (readonly, nonatomic) NSDictionary *cachedSettingsDictionary;
@property (readonly, nonatomic) NSArray *contexts;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithInputMode:(id)mode userModelDataStore:(id)store;
- (id)initWithInputMode:(id)mode userModelDataStore:(id)store weeklyMetricKeys:(id)keys fromDate:(id)date explicitTearDown:(BOOL)down;
- (void)dealloc;
- (void)tearDown;
- (void)configureDurableCounterForName:(id)name;
- (void)configureDurableCounters;
- (id)valuesFromContext:(id)context;
- (void)loadIfNecessary;
- (void)doLoad;
- (id)populateSettingsDictionary;
- (void)loadSettings;
- (BOOL)persistForDate:(id)date;
- (void)trackPowerLogIfNecessary;
- (void)addToDurableCounter:(int)counter forKey:(id)key;
- (void)resetDurableCounterForKey:(id)key;
- (void)addIntegerToTransientCounter:(int)counter forKey:(id)key andCandidateLength:(int)length andContext:(id)context;
- (void)addDoubleToTransientCounter:(double)counter forKey:(id)key andCandidateLength:(int)length andContext:(id)context;
- (int)valueForDurableKey:(id)key;
@end

#endif /* TIUserModel_h */