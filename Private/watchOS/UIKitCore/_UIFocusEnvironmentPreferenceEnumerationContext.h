//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef _UIFocusEnvironmentPreferenceEnumerationContext_h
#define _UIFocusEnvironmentPreferenceEnumerationContext_h
@import Foundation;

#include "UIFocusEnvironment-Protocol.h"
#include "UIFocusSystem.h"
#include "_UIDebugLogStack.h"
#include "_UIFocusEnvironmentPreferenceEnumerationContext-Protocol.h"
#include "_UIFocusEnvironmentPreferenceEnumerationContextDelegate-Protocol.h"

@class NSArray, NSHashTable, NSMapTable, NSMutableArray, NSString;

@interface _UIFocusEnvironmentPreferenceEnumerationContext : NSObject<_UIFocusEnvironmentPreferenceEnumerationContext> {
  /* instance variables */
  UIFocusSystem *_focusSystem;
  NSObject<UIFocusEnvironment> *_preferredSubtree;
  NSMutableArray *_visitedEnvironmentStack;
  NSObject<UIFocusEnvironment> *_lastPrimaryPreferredEnvironment;
  NSArray *_cachedPreferredEnvironments;
  NSHashTable *_allVisitedEnvironments;
  BOOL _hasResolvedPreferredFocusEnvironments;
  BOOL _hasNeverPoppedInPreferredSubtree;
  NSObject<UIFocusEnvironment> *_preferredSubtreeEntryPoint;
  NSMapTable *_preferredEnvironmentsMap;
  BOOL _cachedPrefersNothingFocused;
}

@property (weak, nonatomic) NSObject<_UIFocusEnvironmentPreferenceEnumerationContextDelegate> *delegate;
@property (retain, nonatomic) _UIDebugLogStack *debugStack;
@property (readonly, nonatomic) BOOL inPreferredSubtree;
@property (readonly, nonatomic) NSObject<UIFocusEnvironment> *environment;
@property (readonly, nonatomic) BOOL isPrimaryPreference;
@property (readonly, nonatomic) BOOL isLeafPreference;
@property (readonly, nonatomic) BOOL preferredByItself;
@property (readonly, nonatomic) BOOL prefersNothingFocused;
@property (readonly, nonatomic) NSObject<UIFocusEnvironment> *preferringEnvironment;
@property (readonly, nonatomic) NSArray *preferredEnvironments;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)init;
- (id)initWithFocusEnvironment:(id)environment enumerationMode:(long long)mode;
- (BOOL)isPreferredByItself;
- (BOOL)isInPreferredSubtree;
- (void)_invalidatePreferredEnvironments;
- (void)_resolvePreferredFocusEnvironments;
- (id)_inferPreferencesForEnvironment:(id)environment;
- (BOOL)_isAllowedToPreferEnvironment:(id)environment;
- (void)pushEnvironment:(id)environment;
- (void)popEnvironment;
- (id)_startLogging;
- (void)_stopLogging;
- (void)_reportInferredPreferredFocusEnvironment:(id)environment;
@end

#endif /* _UIFocusEnvironmentPreferenceEnumerationContext_h */