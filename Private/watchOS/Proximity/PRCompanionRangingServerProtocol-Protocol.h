//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 417.0.4.0.0
//
#ifndef PRCompanionRangingServerProtocol_Protocol_h
#define PRCompanionRangingServerProtocol_Protocol_h
@import Foundation;

@protocol PRCompanionRangingServerProtocol <PRServerProtocol>
/* instance methods */
- (void)configureForCompanionRanging:(id)ranging options:(id)options reply:(id /* block */)reply;
- (void)startCompanionRanging:(id)ranging options:(id)options reply:(id /* block */)reply;
- (void)stopCompanionRanging:(id)ranging reply:(id /* block */)reply;
@end

#endif /* PRCompanionRangingServerProtocol_Protocol_h */