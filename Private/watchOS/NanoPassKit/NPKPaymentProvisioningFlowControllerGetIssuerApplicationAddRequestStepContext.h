//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPaymentProvisioningFlowControllerGetIssuerApplicationAddRequestStepContext_h
#define NPKPaymentProvisioningFlowControllerGetIssuerApplicationAddRequestStepContext_h
@import Foundation;

#include "NPKPaymentProvisioningFlowStepContext.h"

@class NSArray, NSData;

@interface NPKPaymentProvisioningFlowControllerGetIssuerApplicationAddRequestStepContext : NPKPaymentProvisioningFlowStepContext

@property (retain, nonatomic) NSArray *certificates;
@property (retain, nonatomic) NSData *nonce;
@property (retain, nonatomic) NSData *nonceSignature;

/* instance methods */
- (id)initWithRequestContext:(id)context;
- (id)description;
@end

#endif /* NPKPaymentProvisioningFlowControllerGetIssuerApplicationAddRequestStepContext_h */