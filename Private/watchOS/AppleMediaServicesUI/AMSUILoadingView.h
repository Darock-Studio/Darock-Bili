//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 5.2.12.0.0
//
#ifndef AMSUILoadingView_h
#define AMSUILoadingView_h
@import Foundation;

#include "AMSUICommonView.h"

@class UIActivityIndicatorView, UILabel;

@interface AMSUILoadingView : AMSUICommonView

@property (retain, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (retain, nonatomic) UILabel *label;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)setLoadingText:(id)text;
- (void)startAnimating;
- (void)stopAnimating;
- (void)layoutSubviews;
- (struct CGSize { double x0; double x1; })sizeThatFits:(struct CGSize { double x0; double x1; })fits;
@end

#endif /* AMSUILoadingView_h */