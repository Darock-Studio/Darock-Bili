//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMDCameraSnapshotRemoteStreamReceiverDelegate_Protocol_h
#define HMDCameraSnapshotRemoteStreamReceiverDelegate_Protocol_h
@import Foundation;

@protocol HMDCameraSnapshotRemoteStreamReceiverDelegate <NSObject>
/* instance methods */
- (void)snapshotStreamReceiver:(id)receiver didStartGettingImage:(id)image sessionID:(id)id;
- (void)snapshotStreamReceiver:(id)receiver didSaveSnapshotFile:(id)file error:(id)error sessionID:(id)id;
@end

#endif /* HMDCameraSnapshotRemoteStreamReceiverDelegate_Protocol_h */