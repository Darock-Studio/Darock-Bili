//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1270.60.4.0.0
//
#ifndef MIBOMWrapper_h
#define MIBOMWrapper_h
@import Foundation;

@interface MIBOMWrapper : NSObject
/* class methods */
+ (BOOL)_countFilesAndBytesInArchiveAtURL:(id)url withBOMCopier:(struct _BOMCopier *)bomcopier totalFiles:(unsigned long long *)files totalUncompressedBytes:(unsigned long long *)bytes error:(id *)error;
+ (BOOL)extractZipArchiveAtURL:(id)url toURL:(id)url withError:(id *)error;
+ (BOOL)extractZipArchiveAtURL:(id)url toURL:(id)url withError:(id *)error extractionProgressBlock:(id /* block */)block;
@end

#endif /* MIBOMWrapper_h */