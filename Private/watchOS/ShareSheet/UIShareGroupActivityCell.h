//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1936.30.51.4.2
//
#ifndef UIShareGroupActivityCell_h
#define UIShareGroupActivityCell_h
@import Foundation;

#include "UICollectionViewCell.h"
#include "_UIHostActivityProxy.h"

@class NSArray, NSString, NSUUID, UIImage, UIImageView, UILabel, UIView, UIVisualEffectView;

@interface UIShareGroupActivityCell : UICollectionViewCell

@property (retain, nonatomic) UIVisualEffectView *vibrantLabelView;
@property (retain, nonatomic) UILabel *titleLabel;
@property (retain, nonatomic) UILabel *labelForPositioning;
@property (retain, nonatomic) UIImageView *activityImageView;
@property (retain, nonatomic) UIView *imageSlotView;
@property (retain, nonatomic) UIView *titleSlotView;
@property (retain, nonatomic) UIView *badgeSlotView;
@property (retain, nonatomic) NSArray *regularConstraints;
@property (retain, nonatomic) NSArray *largeTextConstraints;
@property (nonatomic) BOOL isPulsing;
@property (retain, nonatomic) NSUUID *identifier;
@property (retain, nonatomic) _UIHostActivityProxy *activityProxy;
@property (nonatomic) unsigned int imageSlotID;
@property (nonatomic) unsigned int titleSlotID;
@property (nonatomic) unsigned int badgeSlotID;
@property (copy, nonatomic) NSString *title;
@property (retain, nonatomic) UIImage *image;
@property (nonatomic) BOOL disabled;
@property (nonatomic) BOOL longPressable;

/* instance methods */
- (id)_placeholderString;
- (id)_createTitleLabel;
- (id)initWithFrame:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })frame;
- (void)prepareForReuse;
- (void)setupConstraints;
- (void)traitCollectionDidChange:(id)change;
- (void)_configureImageViewForPlaceholder:(BOOL)placeholder;
- (void)_updateConstraints;
- (void)_updateDarkening;
- (void)setHighlighted:(BOOL)highlighted;
- (void)setSelected:(BOOL)selected;
- (void)startPulsing;
- (void)stopPulsing;
- (void)_updateImageView;
- (void)_updateTitleView;
- (void)_updateBadgeSlotView;
- (BOOL)isDisabled;
- (BOOL)isLongPressable;
@end

#endif /* UIShareGroupActivityCell_h */