//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPassDetailSectionProviderConfiguration_h
#define NPKPassDetailSectionProviderConfiguration_h
@import Foundation;

#include "NPKListCollectionViewSectionProviderConfiguration.h"
#include "NPKContactResolverCreator.h"

@class NPKContactlessPaymentSessionManager, NPKPassAssociatedInfoManager, PKPass;

@interface NPKPassDetailSectionProviderConfiguration : NPKListCollectionViewSectionProviderConfiguration

@property (weak, nonatomic) PKPass *pass;
@property (weak, nonatomic) NPKPassAssociatedInfoManager *passAssociatedInfoManager;
@property (weak, nonatomic) NPKContactlessPaymentSessionManager *paymentSessionManager;
@property (nonatomic) unsigned long long displayStyle;
@property (weak, nonatomic) NPKContactResolverCreator *contactResolverCreator;

/* instance methods */
- (id)initWithPass:(id)pass;
- (id)initWithPass:(id)pass passAssociatedInfoManager:(id)manager paymentSessionManager:(id)manager displayStyle:(unsigned long long)style contactResolverCreator:(id)creator;
- (id)copyWithZone:(struct _NSZone *)zone;
- (id)configurationByApplyingConfiguration:(id)configuration;
@end

#endif /* NPKPassDetailSectionProviderConfiguration_h */