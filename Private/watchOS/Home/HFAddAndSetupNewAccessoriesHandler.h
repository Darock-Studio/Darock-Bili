//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 841.3.9.0.0
//
#ifndef HFAddAndSetupNewAccessoriesHandler_h
#define HFAddAndSetupNewAccessoriesHandler_h
@import Foundation;

@interface HFAddAndSetupNewAccessoriesHandler : NSObject

@property (nonatomic) BOOL isAccessorySetupActive;

/* class methods */
+ (id)sharedHandler;
+ (id)addAndSetupNewAccessoriesForHome:(id)home room:(id)room;

/* instance methods */
- (id)init;
@end

#endif /* HFAddAndSetupNewAccessoriesHandler_h */