//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 327.60.2.0.0
//
#ifndef P256PublicKeyProtocol_Protocol_h
#define P256PublicKeyProtocol_Protocol_h
@import Foundation;

@protocol P256PublicKeyProtocol <NSObject>
/* instance methods */
- (id)initWithData:(id)data error:(id *)error;
- (id)dataRepresentation;
- (BOOL)verifySignature:(id)signature data:(id)data;
@end

#endif /* P256PublicKeyProtocol_Protocol_h */