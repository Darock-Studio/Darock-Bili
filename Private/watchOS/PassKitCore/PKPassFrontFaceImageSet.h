//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPassFrontFaceImageSet_h
#define PKPassFrontFaceImageSet_h
@import Foundation;

#include "PKPassImageSet.h"
#include "PKColor.h"
#include "PKImage.h"

@class NSData;

@interface PKPassFrontFaceImageSet : PKPassImageSet

@property (retain, nonatomic) PKImage *faceImage;
@property (retain, nonatomic) PKColor *faceImageAverageColor;
@property (retain, nonatomic) PKImage *faceShadowImage;
@property (retain, nonatomic) PKImage *footerImage;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } logoRect;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } cobrandLogoRect;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } thumbnailRect;
@property (nonatomic) struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } stripRect;
@property (retain, nonatomic) PKImage *dynamicLayerStaticFallbackImage;
@property (retain, nonatomic) PKImage *backgroundParallaxEmitterImage;
@property (retain, nonatomic) PKImage *backgroundParallaxImage;
@property (retain, nonatomic) PKImage *backgroundParallaxCrossDissolveImage;
@property (retain, nonatomic) PKImage *neutralEmitterImage;
@property (retain, nonatomic) PKImage *neutralImage;
@property (retain, nonatomic) PKImage *foregroundParallaxEmitterImage;
@property (retain, nonatomic) PKImage *foregroundParallaxImage;
@property (retain, nonatomic) PKImage *foregroundParallaxCrossDissolveImage;
@property (retain, nonatomic) PKImage *staticOverlayEmitterImage;
@property (retain, nonatomic) PKImage *staticOverlayImage;
@property (retain, nonatomic) PKImage *transactionEffectEmitterImage;
@property (retain, nonatomic) NSData *transactionEffectEmitterShapeSVGData;

/* class methods */
+ (long long)imageSetType;
+ (id)archiveName;
+ (unsigned int)currentVersion;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithDisplayProfile:(id)profile fileURL:(id)url screenScale:(double)scale suffix:(id)suffix;
- (void)preheatImages;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
@end

#endif /* PKPassFrontFaceImageSet_h */