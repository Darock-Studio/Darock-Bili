//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EMBlockedSenderWriter_Protocol_h
#define EMBlockedSenderWriter_Protocol_h
@import Foundation;

@protocol EMBlockedSenderWriter <NSObject>
/* instance methods */
- (void)blockEmailAddress:(id)address;
- (void)unblockEmailAddress:(id)address;
- (void)blockTokenAddress:(id)address;
- (void)unblockTokenAddress:(id)address;
- (void)blockEmailAddresses:(id)addresses;
- (void)unblockEmailAddresses:(id)addresses;
- (void)blockContact:(id)contact;
- (void)unblockContact:(id)contact;
@end

#endif /* EMBlockedSenderWriter_Protocol_h */