//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 45.2.1.0.0
//
#ifndef WNUISceneTransactionFactory_Protocol_h
#define WNUISceneTransactionFactory_Protocol_h
@import Foundation;

@protocol WNUISceneTransactionFactory <NSObject>

@property (readonly, nonatomic) NSString *sceneIdentifier;
@property (readonly) NSString *transactionIdentifier;
@property (readonly) NSString *infoPlistSceneIdentifier;
@property (readonly) NSString *applicationBundleIdentifier;

/* instance methods */
- (id)makeTransaction;
- (void)sceneCreated:(id)created;
- (void)destroyScene;
@end

#endif /* WNUISceneTransactionFactory_Protocol_h */