//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 379.2.3.0.0
//
#ifndef BLTSectionInfoObserver_h
#define BLTSectionInfoObserver_h
@import Foundation;

#include "BBObserverDelegate-Protocol.h"
#include "BLTSectionInfoObserverDelegate-Protocol.h"

@class BBObserver, BBSettingsGateway, NSString;
@protocol OS_dispatch_queue;

@interface BLTSectionInfoObserver : NSObject<BBObserverDelegate> {
  /* instance variables */
  BBObserver *_observer;
  NSObject<OS_dispatch_queue> *_queue;
  id /* block */ _reloadSectionInfoCompletion;
  BBSettingsGateway *_settingsGateway;
}

@property (weak, nonatomic) NSObject<BLTSectionInfoObserverDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)init;
- (id)initWithSettingsGateway:(id)gateway;
- (void)dealloc;
- (void)_settingsGatewayReconnected:(id)reconnected;
- (void)observer:(id)observer noteServerConnectionStateChanged:(BOOL)changed;
- (id)sectionInfoForSectionID:(id)id;
- (void)reloadWithCompletion:(id /* block */)completion;
- (void)_getUniversalSectionIDs:(id)ids sectionIDEnumerator:(id)idenumerator completion:(id /* block */)completion;
- (void)updateSectionInfoBySectionIDs:(id)ids completion:(id /* block */)completion;
- (void)_reloadSectionInfosWithCompletion:(id /* block */)completion;
- (void)observer:(id)observer updateSectionInfo:(id)info;
- (void)observer:(id)observer removeSection:(id)section;
@end

#endif /* BLTSectionInfoObserver_h */