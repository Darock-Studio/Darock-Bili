//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2000.2.18.0.0
//
#ifndef ArouetBlinkingButton_h
#define ArouetBlinkingButton_h
@import Foundation;

#include "ArouetButton.h"

@class NSString;

@interface ArouetBlinkingButton : ArouetButton

@property (nonatomic) BOOL blinking;
@property (copy, nonatomic) NSString *alternativeTitle;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (BOOL)isOpaque;
- (void)startBlinking;
- (void)stopBlinking;
- (void)touchesBegan:(id)began withEvent:(id)event;
- (void)touchesMoved:(id)moved withEvent:(id)event;
- (void)touchesEnded:(id)ended withEvent:(id)event;
- (void)touchesCancelled:(id)cancelled withEvent:(id)event;
- (void)touchesEstimatedPropertiesUpdated:(id)updated;
@end

#endif /* ArouetBlinkingButton_h */