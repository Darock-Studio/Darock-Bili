//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef CPLInMemoryResourceDownloadTask_h
#define CPLInMemoryResourceDownloadTask_h
@import Foundation;

#include "CPLResourceTransferTask.h"
#include "CPLPlaceholderRecord.h"
#include "CPLResource.h"

@protocol CPLEngineTransportTask, OS_dispatch_queue;

@interface CPLInMemoryResourceDownloadTask : CPLResourceTransferTask {
  /* instance variables */
  NSObject<OS_dispatch_queue> *_queue;
  NSObject<CPLEngineTransportTask> *_transportTask;
}

@property (readonly, copy, nonatomic) id /* block */ launchHandler;
@property (readonly, copy, nonatomic) id /* block */ completionHandler;
@property (readonly, nonatomic) CPLResource *cloudResource;
@property (readonly, nonatomic) CPLPlaceholderRecord *cloudRecord;

/* class methods */
+ (id)failedTaskForResource:(id)resource error:(id)error completionHandler:(id /* block */)handler;

/* instance methods */
- (id)initWithResource:(id)resource taskIdentifier:(id)identifier launchHandler:(id /* block */)handler completionHandler:(id /* block */)handler;
- (void)associateCloudResource:(id)resource ofRecord:(id)record;
- (void)launch;
- (void)cancelTask;
- (void)finishWithData:(id)data error:(id)error;
- (void)launchTransportTask:(id)task;
@end

#endif /* CPLInMemoryResourceDownloadTask_h */