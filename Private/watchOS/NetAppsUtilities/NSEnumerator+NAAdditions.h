//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 93.0.0.0.0
//
#ifndef NSEnumerator_NAAdditions_h
#define NSEnumerator_NAAdditions_h
@import Foundation;

@interface NSEnumerator (NAAdditions)
/* instance methods */
- (id)na_firstObjectPassingTest:(id /* block */)test;
- (id)na_filter:(id /* block */)na_filter;
- (id)na_map:(id /* block */)na_map;
- (BOOL)na_any:(id /* block */)na_any;
- (BOOL)na_all:(id /* block */)na_all;
- (void)na_each:(id /* block */)na_each;
@end

#endif /* NSEnumerator_NAAdditions_h */