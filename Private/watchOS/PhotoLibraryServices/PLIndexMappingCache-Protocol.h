//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLIndexMappingCache_Protocol_h
#define PLIndexMappingCache_Protocol_h
@import Foundation;

@protocol PLIndexMappingCache <NSObject>

@property (readonly, copy, nonatomic) NSObject<NSObject><NSCopying> *cachedIndexMapState;

/* instance methods */
- (BOOL)mappedDataSourceChanged:(id)changed remoteNotificationData:(id)data;
- (Class)derivedChangeNotificationClass;
@optional
/* instance methods */
- (id)currentStateForChange;
@end

#endif /* PLIndexMappingCache_Protocol_h */