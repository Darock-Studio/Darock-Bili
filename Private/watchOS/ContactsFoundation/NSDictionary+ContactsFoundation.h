//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1235.0.0.0.0
//
#ifndef NSDictionary_ContactsFoundation_h
#define NSDictionary_ContactsFoundation_h
@import Foundation;

@interface NSDictionary (ContactsFoundation)
/* instance methods */
- (void)_cn_each:(id /* block */)_cn_each;
- (id)_cn_keysAndValues;
- (id)_cn_filter:(id /* block */)_cn_filter;
- (id)_cn_map:(id /* block */)_cn_map;
- (id)_cn_mapKeys:(id /* block */)keys;
- (id)_cn_mapValues:(id /* block */)values;
- (id)_cn_diff:(id)_cn_diff;
- (id)_cn_objectForKey:(id)key ofClass:(Class)class;
@end

#endif /* NSDictionary_ContactsFoundation_h */