//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 936.60.10.0.0
//
#ifndef MAXpcConnection_h
#define MAXpcConnection_h
@import Foundation;

@class NSString;
@protocol OS_xpc_object;

@interface MAXpcConnection : NSObject

@property (readonly, nonatomic) NSObject<OS_xpc_object> *connection;
@property (readonly, nonatomic) NSString *connectionId;

/* instance methods */
- (id)initWithServiceName:(id)name;
- (BOOL)notValid;
@end

#endif /* MAXpcConnection_h */