//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 311.0.0.0.0
//
#ifndef NPSGizmoServerProtocol_Protocol_h
#define NPSGizmoServerProtocol_Protocol_h
@import Foundation;

@protocol NPSGizmoServerProtocol <NPSServerProtocol>
/* instance methods */
- (void)backupUserDefaultsDomain:(id)domain keys:(id)keys container:(id)container;
- (void)backupFileAtPath:(id)path withCompletionHandler:(id /* block */)handler;
- (void)saveBackupToFile:(id)file withCompletionHandler:(id /* block */)handler;
- (void)loadBackupFromFile:(id)file withCompletionHandler:(id /* block */)handler;
- (void)backupDataFromPath:(id)path withCompletionHandler:(id /* block */)handler;
@end

#endif /* NPSGizmoServerProtocol_Protocol_h */