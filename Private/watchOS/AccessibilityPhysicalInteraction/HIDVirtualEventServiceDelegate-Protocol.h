//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3093.2.4.4.10
//
#ifndef HIDVirtualEventServiceDelegate_Protocol_h
#define HIDVirtualEventServiceDelegate_Protocol_h
@import Foundation;

@protocol HIDVirtualEventServiceDelegate <NSObject>
/* instance methods */
- (BOOL)setProperty:(id)property forKey:(id)key forService:(id)service;
- (id)propertyForKey:(id)key forService:(id)service;
- (id)copyEventMatching:(id)matching forService:(id)service;
- (BOOL)setOutputEvent:(id)event forService:(id)service;
- (void)notification:(long long)notification withProperty:(id)property forService:(id)service;
@end

#endif /* HIDVirtualEventServiceDelegate_Protocol_h */