//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 866.4.0.0.0
//
#ifndef CUIRenditionMetrics_h
#define CUIRenditionMetrics_h
@import Foundation;

#include "NSCopying-Protocol.h"

@interface CUIRenditionMetrics : NSObject<NSCopying> {
  /* instance variables */
  struct CGSize { double width; double height; } _imageSize;
  struct CGSize { double width; double height; } _defaultImageSize;
  struct CGSize { double width; double height; } _edgeBottomLeftMargin;
  struct CGSize { double width; double height; } _edgeTopRightMargin;
  struct CGSize { double width; double height; } _contentBottomLeftMargin;
  struct CGSize { double width; double height; } _contentTopRightMargin;
  double _baseline;
  struct CGSize { double width; double height; } _auxiliary1BottomLeftMargin;
  struct CGSize { double width; double height; } _auxiliary1TopRightMargin;
  struct CGSize { double width; double height; } _auxiliary2BottomLeftMargin;
  struct CGSize { double width; double height; } _auxiliary2TopRightMargin;
  double _scale;
  struct crmFlags { unsigned int x :1 scalesVertically; unsigned int x :1 scalesHorizontally; unsigned int x :14 reserved; } _crmFlags;
}

/* instance methods */
- (id)copyWithZone:(struct _NSZone *)zone;
- (struct CGSize { double x0; double x1; })imageSize;
- (struct CGSize { double x0; double x1; })defaultImageSize;
- (struct CGSize { double x0; double x1; })edgeBottomLeftMargin;
- (struct CGSize { double x0; double x1; })edgeTopRightMargin;
- (struct CGSize { double x0; double x1; })contentBottomLeftMargin;
- (struct CGSize { double x0; double x1; })contentTopRightMargin;
- (double)baseline;
- (struct CGSize { double x0; double x1; })auxiliary1BottomLeftMargin;
- (struct CGSize { double x0; double x1; })auxiliary1TopRightMargin;
- (struct CGSize { double x0; double x1; })auxiliary2BottomLeftMargin;
- (struct CGSize { double x0; double x1; })auxiliary2TopRightMargin;
- (double)scale;
- (BOOL)scalesVertically;
- (BOOL)scalesHorizontally;
- (id)metricsByMirroringHorizontally;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })edgeRect;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })contentRect;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })insetRectWithMetrics:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })metrics;
- (struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })insetContentRectWithMetrics:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })metrics;
- (BOOL)hasOpaqueContentBounds;
- (BOOL)hasAlignmentEdgeMargins;
@end

#endif /* CUIRenditionMetrics_h */