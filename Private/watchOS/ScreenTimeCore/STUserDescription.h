//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 503.2.0.0.0
//
#ifndef STUserDescription_h
#define STUserDescription_h
@import Foundation;

@class NSNumber, NSString;

@interface STUserDescription : NSObject

@property (readonly, copy, nonatomic) NSString *givenName;
@property (readonly, copy, nonatomic) NSString *familyName;
@property (readonly, copy, nonatomic) NSNumber *userDSID;
@property (readonly, copy, nonatomic) NSString *userAltDSID;

/* class methods */
+ (id)currentUser;
+ (void)currentUserWithCompletion:(id /* block */)completion;

/* instance methods */
- (id)initWithGivenName:(id)name familyName:(id)name userDSID:(id)dsid userAltDSID:(id)dsid;
@end

#endif /* STUserDescription_h */