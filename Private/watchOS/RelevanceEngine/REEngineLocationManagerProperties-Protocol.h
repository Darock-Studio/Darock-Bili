//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 472.0.0.0.0
//
#ifndef REEngineLocationManagerProperties_Protocol_h
#define REEngineLocationManagerProperties_Protocol_h
@import Foundation;

@protocol REEngineLocationManagerProperties <REExportedInterface>

@property (readonly) CLLocation *location;
@property (readonly, nonatomic) BOOL monitoringLocation;
@property (readonly, nonatomic) RELocationManager *locationManager;

@end

#endif /* REEngineLocationManagerProperties_Protocol_h */