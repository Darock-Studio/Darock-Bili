//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLQueryStats_h
#define PLQueryStats_h
@import Foundation;

@class NSManagedObjectContext, NSSQLiteDatabaseStatistics;

@interface PLQueryStats : NSObject {
  /* instance variables */
  NSManagedObjectContext *_context;
  NSSQLiteDatabaseStatistics *_preStats;
}

/* class methods */
+ (id)startedQueryStatsWithContext:(id)context;
+ (BOOL)allowedToTrack;
+ (id)byteCountFormatter;

/* instance methods */
- (id)initWithContext:(id)context;
- (id)stopRecordingDescriptionWithFetchCount:(long long)count;
@end

#endif /* PLQueryStats_h */