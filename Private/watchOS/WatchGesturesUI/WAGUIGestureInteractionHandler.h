//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 114.2.2.0.0
//
#ifndef WAGUIGestureInteractionHandler_h
#define WAGUIGestureInteractionHandler_h
@import Foundation;

#include "WAGUIGestureInteractionHandlerProtocol-Protocol.h"

@class NSString, UIView;

@interface WAGUIGestureInteractionHandler : NSObject<WAGUIGestureInteractionHandlerProtocol>

@property (copy, nonatomic) id /* block */ additionalActionBlock;
@property (readonly, weak, nonatomic) UIView *interactionView;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)createHandlerForObject:(id)object;
+ (Class)expectedInteractionViewClass;

/* instance methods */
- (id)initPrivate;
- (void)willMoveToView:(id)view;
- (void)performActionForInteraction:(id)interaction;
- (void)performContinousActionBeganForInteraction:(id)interaction;
- (void)performContinousActionEndedForInteraction:(id)interaction;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })highlightedViewFrameForInteraction:(id)interaction inView:(id)view;
- (id)highlightedViewForInteraction:(id)interaction;
- (BOOL)interactionCanReceiveEvents:(id)events;
@end

#endif /* WAGUIGestureInteractionHandler_h */