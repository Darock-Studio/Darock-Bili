//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 101.0.0.0.0
//
#ifndef StockNewsItemCollection_h
#define StockNewsItemCollection_h
@import Foundation;

@class NSArray;

@interface StockNewsItemCollection : NSObject

@property (retain, nonatomic) NSArray *newsItems;
@property (nonatomic) double expirationTime;

/* instance methods */
- (id)initWithArchiveArray:(id)array;
- (id)archiveArray;
@end

#endif /* StockNewsItemCollection_h */