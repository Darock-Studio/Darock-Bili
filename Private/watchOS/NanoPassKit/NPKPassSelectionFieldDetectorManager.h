//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPassSelectionFieldDetectorManager_h
#define NPKPassSelectionFieldDetectorManager_h
@import Foundation;

#include "NPKFieldPropertiesInspector.h"
#include "NPKFieldPropertiesInspectorDataSource.h"
#include "NPKLeakyBucket.h"
#include "NPKLowPowerModeLocalDeviceMonitor.h"
#include "NPKLowPowerModeMonitorObserver-Protocol.h"
#include "NPKPassSelectionFieldDetectorManagerDelegate-Protocol.h"
#include "NPKPassesDataSource-Protocol.h"
#include "NPKPassesDataSourceObserver-Protocol.h"
#include "PKFieldDetectorObserver-Protocol.h"

@class NSString, PKFieldDetector;
@protocol OS_dispatch_queue;

@interface NPKPassSelectionFieldDetectorManager : NSObject<PKFieldDetectorObserver, NPKPassesDataSourceObserver, NPKLowPowerModeMonitorObserver> {
  /* instance variables */
  PKFieldDetector *_fieldDetector;
  NSObject<OS_dispatch_queue> *_fieldDetectorUpdateQueue;
  BOOL _fieldDetectorEnabled;
  NPKLowPowerModeLocalDeviceMonitor *_lowPowerModeMonitor;
  NPKFieldPropertiesInspector *_fieldPropertyInspector;
  NPKFieldPropertiesInspectorDataSource *_fieldPropertyInspectorDataSource;
  NPKLeakyBucket *_fieldEventBucketControl;
}

@property BOOL fieldDetectEnabled;
@property (weak, nonatomic) NSObject<NPKPassSelectionFieldDetectorManagerDelegate> *delegate;
@property (weak, nonatomic) NSObject<NPKPassesDataSource> *dataSource;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)managerWithDataSource:(id)source lowPowerModeMonitor:(id)monitor delegate:(id)delegate;
+ (id)managerWithDataSource:(id)source lowPowerModeMonitor:(id)monitor;
+ (BOOL)_shouldEnableFieldDetectWithPasses:(id)passes lowPowerModeMonitor:(id)monitor;

/* instance methods */
- (id)initWithDataSource:(id)source lowPowerModeMonitor:(id)monitor delegate:(id)delegate;
- (id)initWithDataSource:(id)source lowPowerModeMonitor:(id)monitor;
- (BOOL)isFieldDetectEnabled;
- (void)fieldDetectorDidEnterField:(id)field withProperties:(id)properties;
- (void)passesDataSourceDidReloadPasses:(id)passes;
- (void)passesDataSource:(id)source didUpdatePasses:(id)passes withStates:(id)states;
- (void)passesDataSource:(id)source didAddPasses:(id)passes;
- (void)passesDataSource:(id)source didRemovePasses:(id)passes;
- (void)passesDataSourceDidReorderPasses:(id)passes;
- (void)lowPowerModeMonitor:(id)monitor didUpdateLowPowerModeEnabled:(BOOL)enabled;
@end

#endif /* NPKPassSelectionFieldDetectorManager_h */