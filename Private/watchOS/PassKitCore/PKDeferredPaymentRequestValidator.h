//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKDeferredPaymentRequestValidator_h
#define PKDeferredPaymentRequestValidator_h
@import Foundation;

#include "PKDeferredPaymentRequest.h"
#include "PKPaymentValidating-Protocol.h"

@class NSString;

@interface PKDeferredPaymentRequestValidator : NSObject<PKPaymentValidating>

@property (readonly, nonatomic) PKDeferredPaymentRequest *deferredPaymentRequest;
@property (copy, nonatomic) NSString *currencyCode;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)validatorWithObject:(id)object;
+ (Class)validatedClass;

/* instance methods */
- (id)initWithDeferredPaymentRequest:(id)request;
- (BOOL)isValidWithError:(id *)error;
- (BOOL)isValidWithAPIType:(long long)apitype withError:(id *)error;
@end

#endif /* PKDeferredPaymentRequestValidator_h */