//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 866.4.0.0.0
//
#ifndef CUIVectorGlyhLayerDelegate_Protocol_h
#define CUIVectorGlyhLayerDelegate_Protocol_h
@import Foundation;

@protocol CUIVectorGlyhLayerDelegate 
/* instance methods */
- (double)scale;
- (double)_requestedPointSizeRatio;
- (float)templateVersion;
- (struct CGSize { double x0; double x1; })referenceCanvasSize;
- (void)_legacy_drawMonochromeLayerNamed:(id)named inContext:(struct CGContext *)context scaleFactor:(double)factor targetSize:(struct CGSize { double x0; double x1; })size onFillColor:(struct CGColor *)color offFillColor:(struct CGColor *)color;
- (void)_legacy_drawMulticolorLayerNamed:(id)named inContext:(struct CGContext *)context scaleFactor:(double)factor targetSize:(struct CGSize { double x0; double x1; })size colorResolver:(id /* block */)resolver;
- (void)_legacy_drawHierarchicalLayerNamed:(id)named inContext:(struct CGContext *)context scaleFactor:(double)factor targetSize:(struct CGSize { double x0; double x1; })size colorResolver:(id /* block */)resolver;
- (struct CGPath *)pathForLayerNamed:(id)named;
- (struct CGSVGAttributeMap *)styleForLayerName:(id)name;
@end

#endif /* CUIVectorGlyhLayerDelegate_Protocol_h */