//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef NTKComplicationPickerStackedImageTextCollectionViewCell_h
#define NTKComplicationPickerStackedImageTextCollectionViewCell_h
@import Foundation;

#include "NTKComplicationPickerCollectionViewCell.h"

@class NSLayoutConstraint;

@interface NTKComplicationPickerStackedImageTextCollectionViewCell : NTKComplicationPickerCollectionViewCell

@property (readonly, nonatomic) unsigned long long spacingMode;
@property (readonly, nonatomic) NSLayoutConstraint *labelSpacingConstraint;
@property (readonly, nonatomic) NSLayoutConstraint *imageSpacingConstraint;
@property (readonly, nonatomic) NSLayoutConstraint *imageHorizontalAlignmentConstraint;

/* instance methods */
- (id)createTextView;
- (void)configureAutolayoutWithImageView:(id)view textView:(id)view;
- (void)prepareForReuse;
- (void)setSpacingForMode:(unsigned long long)mode;
@end

#endif /* NTKComplicationPickerStackedImageTextCollectionViewCell_h */