//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPaymentCardDataItem_h
#define PKPaymentCardDataItem_h
@import Foundation;

#include "PKPaymentDataItem.h"
#include "PKCurrencyAmount.h"
#include "PKPaymentApplication.h"
#include "PKPaymentPass.h"

@class CNContact;

@interface PKPaymentCardDataItem : PKPaymentDataItem

@property (nonatomic) BOOL showPeerPaymentBalance;
@property (retain, nonatomic) PKCurrencyAmount *peerPaymentBalance;
@property (readonly, nonatomic) PKPaymentPass *pass;
@property (readonly, nonatomic) PKPaymentApplication *paymentApplication;
@property (readonly, nonatomic) BOOL requiresBillingAddress;
@property (readonly, nonatomic) CNContact *billingAddress;
@property (readonly, nonatomic) BOOL shouldShowCardArt;

/* class methods */
+ (long long)dataType;

/* instance methods */
- (long long)context;
- (id)errors;
- (id)paymentContactFormatErrors;
- (long long)status;
- (BOOL)isValidWithError:(id *)error;
@end

#endif /* PKPaymentCardDataItem_h */