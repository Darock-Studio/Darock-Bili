//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef HVBudget_h
#define HVBudget_h
@import Foundation;

@interface HVBudget : NSObject {
  /* instance variables */
  unsigned int _alwaysAllowSourcesOverride;
  unsigned int _alwaysDenySourcesOverride;
  unsigned int _noServiceSources;
  unsigned int _periodicBackgroundSources;
  unsigned int _delayedBudgetedSources;
  unsigned int _budgetedSources;
  unsigned int _realtimeSources;
  unsigned int _extraBudgetSources;
  BOOL _ignoreDiscretionaryPowerBudget;
}

/* instance methods */
- (id)init;
@end

#endif /* HVBudget_h */