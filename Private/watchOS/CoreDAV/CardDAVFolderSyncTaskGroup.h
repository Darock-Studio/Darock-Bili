//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1221.1.1.2.0
//
#ifndef CardDAVFolderSyncTaskGroup_h
#define CardDAVFolderSyncTaskGroup_h
@import Foundation;

#include "CoreDAVContainerSyncTaskGroup.h"

@interface CardDAVFolderSyncTaskGroup : CoreDAVContainerSyncTaskGroup

@property (nonatomic) BOOL isInitialSync;

/* instance methods */
- (id)initWithFolderURL:(id)url previousCTag:(id)ctag previousSyncToken:(id)token actions:(id)actions syncItemOrder:(BOOL)order context:(id)context accountInfoProvider:(id)provider taskManager:(id)manager appSpecificDataItemClass:(Class)class;
- (id)initWithFolderURL:(id)url previousCTag:(id)ctag previousSyncToken:(id)token actions:(id)actions context:(id)context accountInfoProvider:(id)provider taskManager:(id)manager appSpecificDataItemClass:(Class)class;
- (id)copyMultiGetTaskWithURLs:(id)urls;
- (id)copyGetTaskWithURL:(id)url;
- (id)dataContentType;
- (Class)bulkChangeTaskClass;
- (void)applyAdditionalPropertiesFromPutTask:(id)task;
@end

#endif /* CardDAVFolderSyncTaskGroup_h */