//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 597.5.2.1.0
//
#ifndef NSUUID_IconServices_h
#define NSUUID_IconServices_h
@import Foundation;

@interface NSUUID (IconServices)
/* class methods */
+ (id)_IS_UUIDWithData:(id)data;
+ (id)_IS_UUIDWithString:(id)string;
+ (id)_IS_UUIDWithInt64:(long long)int64;
+ (id)_IS_UUIDWithOSType:(unsigned int)ostype;
+ (id)_IS_nullUUID;
+ (id)_IS_UUIDWithBytes:(const char *)bytes size:(unsigned long long)size;
+ (id)_IS_UUIDByXORingUUIDs:(id)uuids;

/* instance methods */
- (void)_IS_getUUIDBytes:(char *)uuidbytes hash64:(unsigned long long *)hash64;
@end

#endif /* NSUUID_IconServices_h */