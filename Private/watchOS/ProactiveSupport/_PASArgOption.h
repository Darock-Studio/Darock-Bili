//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 388.0.0.0.0
//
#ifndef _PASArgOption_h
#define _PASArgOption_h
@import Foundation;

@class NSString;

@interface _PASArgOption : NSObject {
  /* instance variables */
  int _longOptionFlag;
}

@property (readonly, copy, nonatomic) NSString *name;
@property (readonly, copy, nonatomic) NSString *shortName;
@property (readonly, copy, nonatomic) NSString *helpDescription;
@property (readonly, copy, nonatomic) NSString *argMetavar;
@property (readonly, nonatomic) BOOL required;

/* class methods */
+ (id)optionWithName:(id)name shortName:(id)name help:(id)help;
+ (id)optionWithName:(id)name shortName:(id)name argMetavar:(id)metavar help:(id)help;
+ (id)optionWithName:(id)name shortName:(id)name argMetavar:(id)metavar help:(id)help required:(BOOL)required;

/* instance methods */
- (id)initWithName:(id)name shortName:(id)name argMetavar:(id)metavar help:(id)help required:(BOOL)required;
- (id)description;
@end

#endif /* _PASArgOption_h */