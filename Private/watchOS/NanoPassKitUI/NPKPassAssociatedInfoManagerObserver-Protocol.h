//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPassAssociatedInfoManagerObserver_Protocol_h
#define NPKPassAssociatedInfoManagerObserver_Protocol_h
@import Foundation;

@protocol NPKPassAssociatedInfoManagerObserver <NSObject>
/* instance methods */
- (void)passAssociatedInfoManager:(id)manager didUpdatePassInfo:(id)info withPassUniqueID:(id)id;
@end

#endif /* NPKPassAssociatedInfoManagerObserver_Protocol_h */