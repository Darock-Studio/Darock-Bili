//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2398.45.8.0.0
//
#ifndef NTKComplicationSnapshotSlotDescriptor_h
#define NTKComplicationSnapshotSlotDescriptor_h
@import Foundation;

#include "NSCopying-Protocol.h"
#include "NSSecureCoding-Protocol.h"
#include "NTKComplicationSnapshotFaceViewRenderingOptions.h"
#include "NTKComplicationStyle.h"
#include "NTKComplicationVariant.h"

@interface NTKComplicationSnapshotSlotDescriptor : NSObject<NSCopying, NSSecureCoding> {
  /* instance variables */
  NTKComplicationSnapshotFaceViewRenderingOptions *_faceViewRenderingOptions;
  BOOL _layoutSnapshotForLegacyPicker;
}

@property (readonly, nonatomic) NTKComplicationVariant *complicationVariant;
@property (readonly, nonatomic) NTKComplicationStyle *complicationStyle;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithComplicationVariant:(id)variant complicationStyle:(id)style;
- (id)initWithFaceDescriptor:(id)descriptor familiesRankedList:(id)list slot:(id)slot curvedText:(BOOL)text layoutSnapshotForLegacyPicker:(BOOL)picker;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
- (id)description;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)faceViewRenderingOptions;
- (long long)family;
- (BOOL)layoutSnapshotForLegacyPicker;
- (BOOL)isStarbearPickerInlineLayout;
@end

#endif /* NTKComplicationSnapshotSlotDescriptor_h */