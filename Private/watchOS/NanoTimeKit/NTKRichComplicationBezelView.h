//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef NTKRichComplicationBezelView_h
#define NTKRichComplicationBezelView_h
@import Foundation;

#include ".h"
#include "NTKRichComplicationBezelView-Protocol.h"

@class NSString, UIBezierPath, UIColor;
@protocol NTKRichComplicationBezelViewDelegate;

@interface NTKRichComplicationBezelView : <NTKRichComplicationBezelView> {
  /* instance variables */
  UIBezierPath *_hitTestPath;
  struct CGRect { struct CGPoint { double x; double y; } origin; struct CGSize { double width; double height; } size; } _hitTestBounds;
  long long _hitTestShape;
  struct CGRect { struct CGPoint { double x; double y; } origin; struct CGSize { double width; double height; } size; } _hitTestShapeFrame;
}

@property (retain, nonatomic) UIColor *bezelTextColor;
@property (nonatomic) double bezelTextWidthInRadius;
@property (nonatomic) double bezelTextAlpha;
@property (readonly, nonatomic) BOOL interactive;
@property (weak, nonatomic) NSObject<NTKRichComplicationBezelViewDelegate> *delegate;
@property (readonly, nonatomic) double bezelTextAngularWidth;
@property (nonatomic) double bezelTextRadius;
@property (weak, nonatomic) NSObject<NTKRichComplicationBezelViewDelegate> *bezelTextDelegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)keylineImageWithFilled:(BOOL)filled forDevice:(id)device;
+ (id)keylineViewForDevice:(id)device;
+ (id)layoutRuleForState:(long long)state faceBounds:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })bounds dialDiameter:(double)diameter forDevice:(id)device;
+ (struct CGAffineTransform { double x0; double x1; double x2; double x3; double x4; double x5; })transformForState:(long long)state;
+ (id)viewWithLegacyComplicationType:(unsigned long long)type;
+ (void)prepareCustomDataAnimation:(id)animation fromEarlierView:(id)view laterView:(id)view isForward:(BOOL)forward;
+ (void)updateCustomDataAnimationFromEarlierView:(id)view laterView:(id)view isForward:(BOOL)forward animationType:(unsigned long long)type animationDuration:(double)duration animationFraction:(float)fraction bezelTextUpdateHandler:(id /* block */)handler;

/* instance methods */
- (id)init;
- (id)initWithFamily:(long long)family;
- (BOOL)pointInside:(struct CGPoint { double x0; double x1; })inside withEvent:(id)event;
- (void)_createHitTestPathIfNecessary;
- (void)_updateHitTestShape:(long long)shape frame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)_setLayoutTransformToView:(id)view origin:(struct CGPoint { double x0; double x1; })origin rotationInDegree:(double)degree centerScale:(double)scale;
@end

#endif /* NTKRichComplicationBezelView_h */