//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1112.2.15.0.0
//
#ifndef CSLUIScreenShotter_h
#define CSLUIScreenShotter_h
@import Foundation;

#include "CSLSScreenshotTaker-Protocol.h"
#include "CSLScreenshotterXPCEndpoint.h"

@class NPSDomainAccessor, NSString;

@interface CSLUIScreenShotter : NSObject<CSLSScreenshotTaker> {
  /* instance variables */
  NPSDomainAccessor *_domainAccessor;
  BOOL _writeToDisk;
  CSLScreenshotterXPCEndpoint *_xpcEndpoint;
}

@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)sharedInstance;

/* instance methods */
- (id)init;
- (void)_syncScreenShotToPhotoLibrary:(id)library imageDate:(id)date type:(unsigned long long)type;
- (void)_sendImage:(id)image forType:(unsigned long long)type options:(unsigned long long)options completion:(id /* block */)completion;
- (void)saveScreenshot:(BOOL)screenshot;
- (void)takeScreenshotWithOptions:(unsigned long long)options completion:(id /* block */)completion;
- (BOOL)screenShotEnabledPreference;
@end

#endif /* CSLUIScreenShotter_h */