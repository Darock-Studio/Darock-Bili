//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLPlaceholderThumbnailManager_h
#define PLPlaceholderThumbnailManager_h
@import Foundation;

@class NSCache;
@protocol OS_dispatch_queue;

@interface PLPlaceholderThumbnailManager : NSObject {
  /* instance variables */
  NSCache *_placeholderDataCache;
  NSCache *_placeholderImageCache;
  NSObject<OS_dispatch_queue> *_isolation;
}

/* class methods */
+ (id)sharedManager;

/* instance methods */
- (id)init;
- (id)_cacheKeyForFormat:(id)format photoImageSize:(struct CGSize { double x0; double x1; })size photoImageColor:(id)color;
- (id)placeholderDataForFormat:(unsigned short)format photoImageSize:(struct CGSize { double x0; double x1; })size width:(int *)width height:(int *)height bytesPerRow:(int *)row dataWidth:(int *)width dataHeight:(int *)height imageDataOffset:(int *)offset;
- (id)newPlaceholderImageForFormat:(unsigned short)format photoImageSize:(struct CGSize { double x0; double x1; })size;
- (id)_placeholderImageWithColor:(id)color;
@end

#endif /* PLPlaceholderThumbnailManager_h */