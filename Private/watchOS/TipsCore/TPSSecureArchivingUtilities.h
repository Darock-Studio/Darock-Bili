//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 720.1.0.0.0
//
#ifndef TPSSecureArchivingUtilities_h
#define TPSSecureArchivingUtilities_h
@import Foundation;

@interface TPSSecureArchivingUtilities : NSObject
/* class methods */
+ (id)syncQueue;
+ (id)unarchivedObjectOfClass:(Class)class forKey:(id)key;
+ (id)unarchivedObjectOfClass:(Class)class forKey:(id)key userDefaults:(id)defaults;
+ (id)unarchivedObjectOfClasses:(id)classes forKey:(id)key;
+ (id)unarchivedObjectOfClasses:(id)classes forKey:(id)key userDefaults:(id)defaults;
+ (void)archivedDataWithRootObject:(id)object forKey:(id)key;
+ (void)archivedDataWithRootObject:(id)object forKey:(id)key userDefaults:(id)defaults;
@end

#endif /* TPSSecureArchivingUtilities_h */