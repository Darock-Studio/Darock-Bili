//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 78.0.0.0.0
//
#ifndef WRReplyStoreInfo_h
#define WRReplyStoreInfo_h
@import Foundation;

@class NSArray, NSString;

@interface WRReplyStoreInfo : NSObject

@property (readonly, nonatomic) unsigned long long defaultCount;
@property (readonly, nonatomic) NSString *defaultsDomain;
@property (readonly, nonatomic) NSString *defaultsKey;
@property (readonly, nonatomic) NSString *defaultsChangedNotificationName;
@property (readonly, nonatomic) BOOL supportsSmartReplies;
@property (readonly, nonatomic) NSArray *hiddenTinkerReplyKeys;

/* class methods */
+ (id)infoForCategory:(unsigned long long)category;

/* instance methods */
@end

#endif /* WRReplyStoreInfo_h */