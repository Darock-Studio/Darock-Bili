//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1262.300.81.4.10
//
#ifndef CKViewModel_h
#define CKViewModel_h
@import Foundation;

@class NSString;

@interface CKViewModel : NSObject

@property (copy, nonatomic) NSString *identifier;

/* instance methods */
- (id)initWithIdentifier:(id)identifier;
- (BOOL)isEqual:(id)equal;
- (unsigned long long)hash;
@end

#endif /* CKViewModel_h */