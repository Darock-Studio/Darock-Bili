//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLPISystemStateNavigationController_h
#define CSLPISystemStateNavigationController_h
@import Foundation;

#include "PUICNavigationController.h"
#include "CSLSButtonHandling-Protocol.h"
#include "CSLSOccluding-Protocol.h"

@class NSString;
@protocol UIViewController<CSLSButtonHandling><CSLSOccluding;

@interface CSLPISystemStateNavigationController : PUICNavigationController<CSLSButtonHandling, CSLSOccluding> {
  /* instance variables */
  UIViewController<CSLSButtonHandling><CSLSOccluding> *_rootViewController;
}

@property (nonatomic) BOOL occluding;
@property (nonatomic) BOOL touchesDisabled;
@property (readonly, nonatomic) BOOL wantsWheelEvents;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)keyPathsForValuesAffectingWantsWheelEvents;

/* instance methods */
- (id)initWithRootViewController:(id)controller;
- (id)_buttonOccludingRootViewController;
- (void)dealloc;
- (void)observeValueForKeyPath:(id)path ofObject:(id)object change:(id)change context:(void *)context;
- (BOOL)handleButton:(unsigned long long)button eventType:(unsigned long long)type;
- (BOOL)shouldAlertManagerPreHandleButtonEventType:(unsigned long long)type;
- (BOOL)isOccluding;
- (BOOL)areTouchesDisabled;
@end

#endif /* CSLPISystemStateNavigationController_h */