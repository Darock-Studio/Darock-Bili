//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 503.2.0.0.0
//
#ifndef STGroupFetchedResultsController_h
#define STGroupFetchedResultsController_h
@import Foundation;

#include "NSFetchedResultsControllerDelegate-Protocol.h"

@class NSArray, NSFetchedResultsController, NSString;
@protocol STGroupFetchedResultsControllerDelegate;

@interface STGroupFetchedResultsController : NSObject<NSFetchedResultsControllerDelegate>

@property (retain, nonatomic) NSFetchedResultsController *resultsController;
@property (retain, nonatomic) NSArray *resultsControllers;
@property (retain, nonatomic) NSArray *resultsRequests;
@property (nonatomic) unsigned long long changeCounter;
@property (weak, nonatomic) NSObject<STGroupFetchedResultsControllerDelegate> *delegate;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* instance methods */
- (id)initWithContext:(id)context resultsRequests:(id)requests;
- (id)initWithResultsRequests:(id)requests cacheName:(id)name managedObjectContext:(id)context;
- (void)controller:(id)controller didChangeObject:(id)object atIndexPath:(id)path forChangeType:(unsigned long long)type newIndexPath:(id)path;
- (void)controllerWillChangeContent:(id)content;
- (void)controllerDidChangeContent:(id)content;
- (void)_evaluateCounter;
@end

#endif /* STGroupFetchedResultsController_h */