//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1552.3.6.1.1
//
#ifndef PKPayLaterFinancingPlanInstallmentCell_h
#define PKPayLaterFinancingPlanInstallmentCell_h
@import Foundation;

#include "PKPayLaterIconCell.h"

@class NSNumberFormatter, PKPayLaterFinancingPlan, PKPayLaterInstallment;

@interface PKPayLaterFinancingPlanInstallmentCell : PKPayLaterIconCell {
  /* instance variables */
  PKPayLaterFinancingPlan *_financingPlan;
  PKPayLaterInstallment *_installment;
  NSNumberFormatter *_numberFormatter;
}

/* instance methods */
- (void)setFinancingPlan:(id)plan installment:(id)installment rowIndex:(long long)index paymentIntentController:(id)controller presentingViewController:(id)controller;
- (void)prepareForReuse;
@end

#endif /* PKPayLaterFinancingPlanInstallmentCell_h */