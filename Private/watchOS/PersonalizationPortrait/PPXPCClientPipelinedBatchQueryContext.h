//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1226.2.2.1.0
//
#ifndef PPXPCClientPipelinedBatchQueryContext_h
#define PPXPCClientPipelinedBatchQueryContext_h
@import Foundation;

@protocol OS_dispatch_queue;

@interface PPXPCClientPipelinedBatchQueryContext : NSObject {
  /* instance variables */
  BOOL _stop;
  id /* block */ _finalizeCall;
  struct atomic_flag { atomic  _Value; BOOL x0; } _calledFinalizeBlock;
}

@property (retain, nonatomic) NSObject<OS_dispatch_queue> *queue;
@property (copy, nonatomic) id /* block */ handleBatch;

/* instance methods */
- (void)setFinalizeCall:(id /* block */)call;
- (void)finalizeCallWithSuccess:(BOOL)success error:(id)error;
- (id)description;
@end

#endif /* PPXPCClientPipelinedBatchQueryContext_h */