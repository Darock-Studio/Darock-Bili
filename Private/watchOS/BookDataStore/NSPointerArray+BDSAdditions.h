//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1062.0.0.0.0
//
#ifndef NSPointerArray_BDSAdditions_h
#define NSPointerArray_BDSAdditions_h
@import Foundation;

@interface NSPointerArray (BDSAdditions)
/* instance methods */
- (void)bds_chainSuccessAndErrorCompletionSelectorCallsForSelector:(SEL)selector successSoFar:(BOOL)far errorSoFar:(id)far completion:(id /* block */)completion;
- (void)bds_chainUntilNoErrorCompletionSelectorCallsForSelector:(SEL)selector successSoFar:(BOOL)far errorSoFar:(id)far completion:(id /* block */)completion;
@end

#endif /* NSPointerArray_BDSAdditions_h */