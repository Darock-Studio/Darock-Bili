//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 554.40.9.0.0
//
#ifndef _IXSimpleInstallerDelegate_h
#define _IXSimpleInstallerDelegate_h
@import Foundation;

#include "IXAppInstallCoordinatorObserver-Protocol.h"

@class NSString, NSURL;
@protocol IXAppInstallCoordinator<IXInitiatingOrUpdatingCoordinator;

@interface _IXSimpleInstallerDelegate : NSObject<IXAppInstallCoordinatorObserver>

@property (copy, nonatomic) id /* block */ completion;
@property (copy, nonatomic) id /* block */ progressBlock;
@property (copy, nonatomic) NSString *bundleID;
@property (retain, nonatomic) IXAppInstallCoordinator<IXInitiatingOrUpdatingCoordinator> *coordinator;
@property (retain, nonatomic) NSURL *moveResultToURL;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (void)coordinatorDidCompleteSuccessfully:(id)successfully forApplicationRecord:(id)record;
- (void)coordinator:(id)coordinator canceledWithReason:(id)reason client:(unsigned long long)client;
- (void)coordinator:(id)coordinator didUpdateProgress:(double)progress forPhase:(unsigned long long)phase overallProgress:(double)progress;
@end

#endif /* _IXSimpleInstallerDelegate_h */