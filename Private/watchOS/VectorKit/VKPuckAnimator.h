//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1899.42.9.28.10
//
#ifndef VKPuckAnimator_h
#define VKPuckAnimator_h
@import Foundation;

#include "VKPuckAnimatorDelegate-Protocol.h"
#include "VKPuckAnimatorLocationProjector.h"
#include "VKRunningCurve.h"
#include "VKTimedAnimation.h"

@protocol VKPuckAnimatorTarget, struct Matrix<double, 3, 1> { double x0[3] }, struct optional<std::pair<geo::Mercator3<double>, geo::Mercator3<double>>> { union { char x0; struct pair<geo::Mercator3<double>, geo::Mercator3<double>> { struct Mercator3<double> { double x0[3] } x0; struct Mercator3<double> { double x0[3] } x1; } x1; } x0; BOOL x1; }, {Matrix<double, 3, 1>="_e"[3d]}, {Monitorable<md::ConfigValue<GEOConfigKeyDouble, double>>="_key"{?="key"{?="identifier"I"metadata"^v}}"_value"d"_listener"@"_delegate"{function<void (double)>="__f_"{__value_func<void (double)>="__buf_"{type="__lx"[24C]}"__f_"^v}}}, {linear_map<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>, std::equal_to<unsigned long long>, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>, std::vector<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>>="_backing"{vector<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>>="__begin_"^v"__end_"^v"__end_cap_"{__compressed_pair<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>> *, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>>="__value_"^v}}}, {optional<md::LocationUpdate>=""(?="__null_state_"c"__val_"{LocationUpdate="location"@"CLLocation""routeMatch"@"GEORouteMatch""locationUpdateUUID"@"NSUUID"})"__engaged_"B};

@interface VKPuckAnimator : NSObject {
  /* instance variables */
  VKTimedAnimation *_animation;
  VKRunningCurve *_curve;
  VKPuckAnimatorLocationProjector *_locationProjector;
  double _vehicleHeading;
  long long _pausedCount;
  BOOL _suspended;
  BOOL _hasElevation;
  BOOL _resetCourse;
  struct { double latitude; double longitude; } _lastProjectedCoordinate;
  const struct RouteOverlayCache { undefined * * x0; id x1; } * _routeOverlayCache;
  struct linear_map<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>, std::equal_to<unsigned long long>, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>, std::vector<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>> { struct vector<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>> { void *__begin_; void *__end_; struct __compressed_pair<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>> *, std::allocator<std::pair<unsigned long long, std::function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)>>>> { void *__value_; } __end_cap_; } _backing; } _locationUpdateSubscriptions;
  struct Monitorable<md::ConfigValue<GEOConfigKeyDouble, double>> { struct { struct { unsigned int identifier; void *metadata; } key; } _key; double _value; _delegate *_listener; struct function<void (double)> { struct __value_func<void (double)> { struct type { unsigned char x[24] __lx; } __buf_; void *__f_; } __f_; } x0; } _puckUpdatePointDeltaForAnimation;
  struct Monitorable<md::ConfigValue<GEOConfigKeyDouble, double>> { struct { struct { unsigned int identifier; void *metadata; } key; } _key; double _value; _delegate *_listener; struct function<void (double)> { struct __value_func<void (double)> { struct type { unsigned char x[24] __lx; } __buf_; void *__f_; } __f_; } x0; } _puckUpdateDistanceDeltaThreshold;
  struct optional<md::LocationUpdate> { union { char __null_state_; struct LocationUpdate { CLLocation *location; GEORouteMatch *routeMatch; NSUUID *locationUpdateUUID; } __val_; } x0; BOOL __engaged_; } _lastLocationUpdate;
}

@property (readonly, nonatomic) struct optional<std::pair<geo::Mercator3<double>, geo::Mercator3<double>>> { union { char x0; struct pair<geo::Mercator3<double>, geo::Mercator3<double>> { struct Mercator3<double> { double x0[3] } x0; struct Mercator3<double> { double x0[3] } x1; } x1; } x0; BOOL x1; } currentSnappedSegment;
@property (nonatomic) struct Matrix<double, 3, 1> { double x0[3] } lastProjectedPosition;
@property (nonatomic) BOOL alwaysUseGoodRouteMatch;
@property (retain, nonatomic) NSObject<VKPuckAnimatorTarget> *target;
@property (weak, nonatomic) NSObject<VKPuckAnimatorDelegate> *delegate;
@property (nonatomic) double tracePlaybackSpeedMultiplier;
@property (nonatomic) unsigned long long behavior;

/* instance methods */
- (id)initWithCallbackQueue:(id)queue;
- (void)dealloc;
- (unsigned long long)subscribeToLocationUpdates:(struct function<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)> { struct __value_func<void (VKPuckAnimator *, CLLocation *, GEORouteMatch *, NSUUID *)> { struct type { unsigned char x0[24] } x0; void * x1; } x0; })updates;
- (void)unsubscribeFromLocationUpdates:(unsigned long long)updates;
- (void)updatedPosition:(const void *)position;
- (void)_publishLocationUpdate:(id)update routeMatch:(id)match uuid:(id)uuid;
- (void)start;
- (void)stop;
- (void)pause;
- (void)resume;
- (void)_step;
- (void)processLocationUpdates;
- (void)resetCourse;
- (void)_updateLocation:(id)location routeMatch:(id)match locationUpdateUUID:(id)uuid;
- (void)updateLocation:(id)location routeMatch:(id)match;
- (void)updateLocation:(id)location routeMatch:(id)match locationUpdateUUID:(id)uuid;
- (void)_queueLocationUpdate:(id)update routeMatch:(id)match locationUpdateUUID:(id)uuid;
- (void)updateVehicleHeading:(double)heading;
- (id)detailedDescription;
- (void)setRouteOverlayCache:(const struct RouteOverlayCache { undefined * * x0; id x1; } *)cache;
- (BOOL)hasElevation;
@end

#endif /* VKPuckAnimator_h */