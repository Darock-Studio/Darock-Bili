//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EDBrandIndicatorChangeHookResponder_Protocol_h
#define EDBrandIndicatorChangeHookResponder_Protocol_h
@import Foundation;

@protocol EDBrandIndicatorChangeHookResponder <NSObject>
/* instance methods */
- (void)persistenceDidAddBrandIndicator:(id)indicator forLocation:(id)location;
@end

#endif /* EDBrandIndicatorChangeHookResponder_Protocol_h */