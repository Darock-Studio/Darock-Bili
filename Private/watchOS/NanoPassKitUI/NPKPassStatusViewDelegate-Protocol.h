//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1161.4.0.0.0
//
#ifndef NPKPassStatusViewDelegate_Protocol_h
#define NPKPassStatusViewDelegate_Protocol_h
@import Foundation;

@protocol NPKPassStatusViewDelegate <NSObject>
/* instance methods */
- (id)expressModeSettingsCoordinatorForPassStatusView:(id)view;
- (BOOL)isPeripheralConnectedForPass:(id)pass passStatusView:(id)view;
- (unsigned long long)rangingSuspensionReasonForPass:(id)pass passStatusView:(id)view;
- (BOOL)canPerformRKEActionsForPass:(id)pass passStatusView:(id)view;
@end

#endif /* NPKPassStatusViewDelegate_Protocol_h */