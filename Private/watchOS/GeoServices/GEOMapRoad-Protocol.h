//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1940.42.9.28.8
//
#ifndef GEOMapRoad_Protocol_h
#define GEOMapRoad_Protocol_h
@import Foundation;

@protocol GEOMapRoad <GEOMapLine>

@property (readonly, nonatomic) int roadClass;
@property (readonly, nonatomic) int formOfWay;
@property (readonly, nonatomic) int travelDirection;
@property (readonly, nonatomic) double roadWidth;
@property (readonly, nonatomic) unsigned long long speedLimit;
@property (readonly, nonatomic) BOOL speedLimitIsMPH;
@property (readonly, nonatomic) unsigned long long roadID;
@property (readonly, nonatomic) BOOL isTunnel;
@property (readonly, nonatomic) BOOL isBridge;
@property (readonly, nonatomic) BOOL isRail;
@property (readonly, nonatomic) int rampType;
@property (readonly, nonatomic) NSString *internalRoadName;

/* instance methods */
- (void)roadFeaturesWithHandler:(id /* block */)handler;
- (void)roadEdgesWithHandler:(id /* block */)handler;
- (id)findRoadsFrom:(id /* block */)from completionHandler:(id /* block */)handler;
- (id)findRoadsFromPreviousIntersection:(id /* block */)intersection completionHandler:(id /* block */)handler;
- (id)findRoadsToPreviousIntersection:(id /* block */)intersection completionHandler:(id /* block */)handler;
- (id)findRoadsFromNextIntersection:(id /* block */)intersection completionHandler:(id /* block */)handler;
- (id)findRoadsToNextIntersection:(id /* block */)intersection completionHandler:(id /* block */)handler;
@end

#endif /* GEOMapRoad_Protocol_h */