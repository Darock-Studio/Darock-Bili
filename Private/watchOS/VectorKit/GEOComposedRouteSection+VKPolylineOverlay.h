//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1899.42.9.28.10
//
#ifndef GEOComposedRouteSection_VKPolylineOverlay_h
#define GEOComposedRouteSection_VKPolylineOverlay_h
@import Foundation;

#include "GEOComposedRouteObserver-Protocol.h"
#include "VKRouteLine.h"
#include "VKRouteOverlay-Protocol.h"

@class GEOComposedRoute, GEOComposedRouteTraffic, GEOMapRegion, NSString;
@protocol VKPolylineOverlayRouteRibbonObserver, {unique_ptr<md::TrafficSegmentsAlongRoute, std::default_delete<md::TrafficSegmentsAlongRoute>>="__ptr_"{__compressed_pair<md::TrafficSegmentsAlongRoute *, std::default_delete<md::TrafficSegmentsAlongRoute>>="__value_"^{TrafficSegmentsAlongRoute}}};

@interface GEOComposedRouteSection (VKPolylineOverlay)
/* instance methods */
- (id)pathsForRenderRegion:(id)region inOverlay:(id)overlay shouldSnapToTransit:(BOOL)transit verifySnapping:(BOOL)snapping;
- (id)pathsForRenderRegion:(id)region inOverlay:(id)overlay;
- (id)pathsForRenderRegion:(id)region inOverlay:(id)overlay excludedSegments:(const void *)segments;
- (struct Box<double, 2> { struct Matrix<double, 2, 1> { double x0[2] } x0; struct Matrix<double, 2, 1> { double x0[2] } x1; })vkBounds;
@end

#endif /* GEOComposedRouteSection_VKPolylineOverlay_h */