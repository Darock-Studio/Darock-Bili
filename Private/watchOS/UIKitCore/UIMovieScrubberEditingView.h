//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 7209.1.301.0.0
//
#ifndef UIMovieScrubberEditingView_h
#define UIMovieScrubberEditingView_h
@import Foundation;

#include "UIView.h"
#include "UIImageView.h"

@class NSArray;

@interface UIMovieScrubberEditingView : UIView {
  /* instance variables */
  UIImageView *_leftImageView;
  UIImageView *_middleImageView;
  UIImageView *_rightImageView;
  NSArray *_activeImages;
  NSArray *_activeNoEditImages;
  NSArray *_inactiveImages;
}

@property (nonatomic) BOOL enabled;
@property (nonatomic) BOOL editing;
@property (nonatomic) double edgeInset;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)layoutSubviews;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })_leftHandleRect;
- (BOOL)pointInsideLeftHandle:(struct CGPoint { double x0; double x1; })handle;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })_rightHandleRect;
- (BOOL)pointInsideRightHandle:(struct CGPoint { double x0; double x1; })handle;
- (int)handleForPoint:(struct CGPoint { double x0; double x1; })point hitOffset:(double *)offset;
- (id)_handleImages;
- (void)_updateHandleImages;
- (void)bounce;
- (double)_bounceValueForFraction:(double)fraction;
- (BOOL)isEnabled;
- (BOOL)isEditing;
@end

#endif /* UIMovieScrubberEditingView_h */