//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HKSecondaryDevicePairingAgentServerInterface_Protocol_h
#define HKSecondaryDevicePairingAgentServerInterface_Protocol_h
@import Foundation;

@protocol HKSecondaryDevicePairingAgentServerInterface <HKUnitTestingTaskServerInterface>
/* instance methods */
- (void)remote_requestTinkerSharingOptInWithGuardianDisplayName:(id)name NRDeviceUUID:(id)uuid completion:(id /* block */)completion;
- (void)remote_setupHealthSharingForSecondaryPairedDeviceWithConfiguration:(id)configuration completion:(id /* block */)completion;
- (void)remote_performEndToEndCloudSyncWithNRDeviceUUID:(id)uuid syncParticipantFirst:(BOOL)first completion:(id /* block */)completion;
- (void)remote_tearDownHealthSharingWithTinkerDeviceWithNRUUID:(id)nruuid completion:(id /* block */)completion;
- (void)remote_tearDownHealthSharingWithPairedGuardianWithCompletion:(id /* block */)completion;
- (void)remote_fetchSharingStatusWithPairedGuardianWithCompletion:(id /* block */)completion;
- (void)remote_fetchSharingStatusForCurrentAppleIDWithOwnerEmailAddress:(id)address completion:(id /* block */)completion;
@end

#endif /* HKSecondaryDevicePairingAgentServerInterface_Protocol_h */