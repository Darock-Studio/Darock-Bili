//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 949.0.0.0.0
//
#ifndef NWCHourlyForecastViewBuildable_Protocol_h
#define NWCHourlyForecastViewBuildable_Protocol_h
@import Foundation;

@protocol NWCHourlyForecastViewBuildable <NSObject>

@property (readonly, nonatomic) CLKDevice *device;

/* instance methods */
- (id)initWithDevice:(id)device;
- (id)createHourlyForecastView;
@end

#endif /* NWCHourlyForecastViewBuildable_Protocol_h */