//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.3.0.0
//
#ifndef NSUUID_MSVBase64_h
#define NSUUID_MSVBase64_h
@import Foundation;

@interface NSUUID (MSVBase64)
/* class methods */
+ (id)uuidWithMSVBase64UUID:(id)uuid;
+ (id)msv_UUIDWithData:(id)data;
+ (id)msv_uuidWithCFUUID:(struct __CFUUID *)cfuuid;

/* instance methods */
- (id)initWithMSVBase64UUIDString:(id)uuidstring;
- (id)MSVBase64UUIDString;
- (id)msv_UUIDData;
- (struct __CFUUID *)msv_copyCFUUID;
@end

#endif /* NSUUID_MSVBase64_h */