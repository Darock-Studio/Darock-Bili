//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 5.2.12.0.0
//
#ifndef AMSUIWebCameraReaderInfoView_h
#define AMSUIWebCameraReaderInfoView_h
@import Foundation;

#include "AMSUICommonView.h"
#include "AMSUIWebActionRunnable-Protocol.h"

@class UIButton, UILabel;

@interface AMSUIWebCameraReaderInfoView : AMSUICommonView

@property (retain, nonatomic) UIButton *bottomLink;
@property (retain, nonatomic) NSObject<AMSUIWebActionRunnable> *bottomLinkAction;
@property (retain, nonatomic) UILabel *primaryLabel;
@property (retain, nonatomic) UILabel *secondaryLabel;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)layoutSubviews;
- (void)_bottomLinkSelected:(id)selected;
- (id)_createButtonWithTarget:(id)target selector:(SEL)selector;
- (id)_createLabelWithLines:(long long)lines title:(BOOL)title;
@end

#endif /* AMSUIWebCameraReaderInfoView_h */