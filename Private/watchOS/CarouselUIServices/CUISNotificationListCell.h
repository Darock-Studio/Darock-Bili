//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CUISNotificationListCell_h
#define CUISNotificationListCell_h
@import Foundation;

#include "PUICPlatterCell.h"
#include "BSDescriptionProviding-Protocol.h"
#include "CUISAlertIconView.h"
#include "CUISMediumLookCellLayoutSpecifications.h"
#include "CUISNotificationCenterCellPlatterView.h"
#include "CUISNotificationCenterNotificationInfo-Protocol.h"
#include "CUISVibrantLabel.h"
#include "CUISVisualEffectView.h"

@class NSArray, NSLayoutConstraint, NSString, UILabel, UIStackView;
@protocol UILabel<BSUIDateLabel;

@interface CUISNotificationListCell : PUICPlatterCell<BSDescriptionProviding> {
  /* instance variables */
  id _notifObserverToken;
  CUISMediumLookCellLayoutSpecifications *_specifications;
}

@property (retain, nonatomic) CUISNotificationCenterCellPlatterView *platterView;
@property (retain, nonatomic) CUISAlertIconView *iconView;
@property (retain, nonatomic) CUISVibrantLabel *topRightView;
@property (retain, nonatomic) CUISVisualEffectView *visualEffectView;
@property (retain, nonatomic) UILabel<BSUIDateLabel> *dateLabel;
@property (retain, nonatomic) UIStackView *contentStackView;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *subtitleLabel;
@property (retain, nonatomic) UILabel *messageLabel;
@property (retain, nonatomic) NSArray *multiNotificationStack;
@property (retain, nonatomic) NSLayoutConstraint *bodyBottomConstraint;
@property (retain, nonatomic) NSObject<CUISNotificationCenterNotificationInfo> *notificationInfo;
@property (nonatomic) unsigned long long notificationCount;
@property (readonly, nonatomic) BOOL isCoalesced;
@property (copy, nonatomic) NSString *appName;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)dealloc;
- (void)createSubviews;
- (void)addSubviewConstraints;
- (void)setFonts;
- (void)prepareForReuse;
- (void)updateDateLabel;
- (void)updateIcon;
- (void)resetLabels;
- (void)updateLabels;
- (void)updateStack;
- (void)updateTextTintColor;
- (void)handleReduceTransparencyStatusDidChange;
- (id)descriptionWithMultilinePrefix:(id)prefix;
- (id)descriptionBuilderWithMultilinePrefix:(id)prefix;
- (id)succinctDescription;
- (id)succinctDescriptionBuilder;
@end

#endif /* CUISNotificationListCell_h */