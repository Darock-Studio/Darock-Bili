//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 384.60.3.0.0
//
#ifndef UMTask_h
#define UMTask_h
@import Foundation;

@class NSString, NSUUID;

@interface UMTask : NSObject {
  /* instance variables */
  NSUUID *_uuid;
}

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *reason;
@property (copy, nonatomic) NSString *bundleID;
@property (nonatomic) BOOL isFinished;
@property (nonatomic) int pid;

/* class methods */
+ (id)taskWithName:(id)name reason:(id)reason;
+ (id)taskWithName:(id)name reason:(id)reason forBundleID:(id)id;

/* instance methods */
- (id)init;
- (void)begin;
- (void)end;
- (id)description;
@end

#endif /* UMTask_h */