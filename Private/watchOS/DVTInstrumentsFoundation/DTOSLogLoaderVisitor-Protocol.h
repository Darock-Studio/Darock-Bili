//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 64562.3.1.1.0
//
#ifndef DTOSLogLoaderVisitor_Protocol_h
#define DTOSLogLoaderVisitor_Protocol_h
@import Foundation;

@protocol DTOSLogLoaderVisitor 

@property (retain, nonatomic) NSData *nextOutputBytes;
@property (nonatomic) BOOL fetchComplete;
@property (nonatomic) unsigned long long lastMachContinuousTime;
@property (nonatomic) unsigned int lostEventsSinceLastVisit;
@property (retain, nonatomic) NSError *failureReason;

/* instance methods */
- (void)addPidToExecEntriesFromMapping:(id)mapping;
- (BOOL)isFetchComplete;
@end

#endif /* DTOSLogLoaderVisitor_Protocol_h */