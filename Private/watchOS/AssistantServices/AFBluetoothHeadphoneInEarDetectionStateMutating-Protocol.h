//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.23.5.2.1
//
#ifndef AFBluetoothHeadphoneInEarDetectionStateMutating_Protocol_h
#define AFBluetoothHeadphoneInEarDetectionStateMutating_Protocol_h
@import Foundation;

@protocol AFBluetoothHeadphoneInEarDetectionStateMutating <NSObject>
/* instance methods */
- (void)setIsEnabled:(BOOL)enabled;
- (void)setPrimaryEarbudSide:(long long)side;
- (void)setPrimaryInEarStatus:(long long)status;
- (void)setSecondaryInEarStatus:(long long)status;
@end

#endif /* AFBluetoothHeadphoneInEarDetectionStateMutating_Protocol_h */