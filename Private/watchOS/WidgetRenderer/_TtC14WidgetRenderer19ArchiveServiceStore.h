//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 402.23.0.0.0
//
#ifndef _TtC14WidgetRenderer19ArchiveServiceStore_h
#define _TtC14WidgetRenderer19ArchiveServiceStore_h
@import Foundation;

#include "_TtCs12_SwiftObject.h"

@interface WidgetRenderer.ArchiveServiceStore : Swift._SwiftObject { // (Swift)
  /* instance variables */
   _queue;
   _label;
   _logger;
   _environmentFactory;
   _descriptorProvider;
   _dataProtectionProvider;
   _dataProtectionMonitor;
   _cacheReader;
   _updateTimer;
   _lock;
   _lock_storage;
   _lock_currentDataProtectionLevel;
   _subscriptions;
}

@end

#endif /* _TtC14WidgetRenderer19ArchiveServiceStore_h */