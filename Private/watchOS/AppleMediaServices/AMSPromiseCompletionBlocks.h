//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tools: [ld (607.2), ld (814.1), ld (902.8)]
//    - LC_SOURCE_VERSION: 7.2.10.0.0
//
#ifndef AMSPromiseCompletionBlocks_h
#define AMSPromiseCompletionBlocks_h
@import Foundation;

@class NSMutableArray;

@interface AMSPromiseCompletionBlocks : NSObject {
  /* instance variables */
  struct os_unfair_lock_s { unsigned int _os_unfair_lock_opaque; } _completionBlockLock;
  NSMutableArray *_completionBlocks;
  BOOL _shouldCallImmediately;
}

/* instance methods */
- (id)init;
- (void)addCompletionBlock:(id /* block */)block;
- (void)addErrorBlock:(id /* block */)block;
- (void)addSuccessBlock:(id /* block */)block;
- (void)callCompletionBlock:(id /* block */)block withPromiseResult:(id)result;
- (void)callErrorBlock:(id /* block */)block withPromiseResult:(id)result;
- (void)callSuccessBlock:(id /* block */)block withPromiseResult:(id)result;
- (void)flushCompletionBlocksWithPromiseResult:(id)result;
@end

#endif /* AMSPromiseCompletionBlocks_h */