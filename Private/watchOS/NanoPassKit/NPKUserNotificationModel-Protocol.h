//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKUserNotificationModel_Protocol_h
#define NPKUserNotificationModel_Protocol_h
@import Foundation;

@protocol NPKUserNotificationModel <NSObject>

@property (readonly, nonatomic) NSString *title;
@property (readonly, nonatomic) NSString *body;
@property (readonly, nonatomic) NSDictionary *userInfo;
@property (readonly, nonatomic) NSString *notificationCategoryIdentifier;
@property (readonly, nonatomic) NSString *identifier;
@property (readonly, nonatomic) BOOL wantsBadgedIcon;
@property (readonly, nonatomic) BOOL suppressed;

/* instance methods */
- (BOOL)isSuppressed;
@end

#endif /* NPKUserNotificationModel_Protocol_h */