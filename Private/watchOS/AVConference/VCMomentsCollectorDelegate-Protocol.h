//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2005.6.1.3.2
//
#ifndef VCMomentsCollectorDelegate_Protocol_h
#define VCMomentsCollectorDelegate_Protocol_h
@import Foundation;

@protocol VCMomentsCollectorDelegate <NSObject>
/* instance methods */
- (void)stream:(id)stream addVideoSampleBuffer:(struct opaqueCMSampleBuffer *)buffer cameraStatusBits:(unsigned char)bits timestamp:(unsigned int)timestamp;
- (void)stream:(id)stream addAudioSampleBuffer:(struct opaqueVCAudioBufferList *)buffer timestamp:(unsigned int)timestamp;
- (void)cleanupActiveRequests;
@end

#endif /* VCMomentsCollectorDelegate_Protocol_h */