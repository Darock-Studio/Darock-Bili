//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPaymentTransactionPresentationInformation_h
#define NPKPaymentTransactionPresentationInformation_h
@import Foundation;

@class NSString, UIColor;

@interface NPKPaymentTransactionPresentationInformation : NSObject

@property (retain, nonatomic) NSString *primaryString;
@property (retain, nonatomic) NSString *secondaryString;
@property (retain, nonatomic) NSString *tertiaryString;
@property (retain, nonatomic) UIColor *customSecondaryColor;
@property (retain, nonatomic) NSString *rewardsString;
@property (nonatomic) long long rewardsStringRedactionStyle;
@property (retain, nonatomic) NSString *valueString;
@property (nonatomic) long long valueStringRedactionStyle;
@property (nonatomic) BOOL shouldGrayValue;
@property (nonatomic) BOOL shouldStrikeValue;
@property (nonatomic) BOOL shouldShowDisclosure;

/* instance methods */
- (id)description;
@end

#endif /* NPKPaymentTransactionPresentationInformation_h */