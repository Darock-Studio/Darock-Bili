//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tools: [ld (607.2), ld (814.1), ld (902.8)]
//    - LC_SOURCE_VERSION: 7.2.10.0.0
//
#ifndef AMSDataMigratorOptions_h
#define AMSDataMigratorOptions_h
@import Foundation;

@class NSArray, NSString;

@interface AMSDataMigratorOptions : NSObject

@property (copy, nonatomic) NSString *currentBuildVersion;
@property (readonly, nonatomic) NSArray *optionsArray;
@property (copy, nonatomic) NSString *previousBuildVersion;
@property (nonatomic) unsigned long long scenario;

/* class methods */
+ (id)_stringFromOptionsArray:(id)array atIndex:(unsigned long long)index;

/* instance methods */
- (id)init;
- (id)initWithOptionsArray:(id)array;
@end

#endif /* AMSDataMigratorOptions_h */