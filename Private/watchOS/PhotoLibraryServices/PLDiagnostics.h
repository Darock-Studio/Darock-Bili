//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 624.0.100.0.0
//
#ifndef PLDiagnostics_h
#define PLDiagnostics_h
@import Foundation;

@interface PLDiagnostics : NSObject
/* class methods */
+ (id)logDirectoryURL;
+ (id)diagnosticsURLs;
+ (void)enumerateDiagnosticsURLsIncludingPropertyiesForKeys:(id)keys handler:(id /* block */)handler;
+ (id)matchingNameExpression;
+ (id)excludingNameExpression;
+ (unsigned long long)addOSStateHandlerWithTitle:(id)title queue:(id)queue propertyListHandler:(id /* block */)handler;
+ (BOOL)tapToRadarKitDisabled;
+ (void)tapToRadarWithTitle:(id)title description:(id)description radarComponent:(long long)component displayReason:(id)reason attachments:(id)attachments;
+ (void)_tapToRadarKitDraftWithTitle:(id)title description:(id)description radarComponent:(long long)component displayReason:(id)reason attachments:(id)attachments;
+ (id)_tapToRadarProcessName;
+ (long long)_deviceClassesFromDeviceClassesString:(id)string;
+ (void)_fallBackTapToRadarWithTitle:(id)title description:(id)description radarComponent:(long long)component;
+ (void)_radarComponentDetailsForComponent:(long long)component reply:(id /* block */)reply;
+ (BOOL)shouldSuppressRadarUserNotificationWithMessage:(id)message radarTitle:(id)title;
+ (void)fileRadarUserNotificationWithHeader:(id)header message:(id)message radarTitle:(id)title radarDescription:(id)description;
+ (void)fileRadarUserNotificationWithHeader:(id)header message:(id)message radarTitle:(id)title radarDescription:(id)description radarComponent:(long long)component diagnosticTTRType:(short)ttrtype attachments:(id)attachments extensionItem:(id)item;
+ (id)_memoriesRelatedOutputPathBaseDirectoryWithPathManager:(id)manager;
+ (id)memoriesAndRelatedDiagnosticsOutputURLWithPathManager:(id)manager;
+ (id)createOrEmptyMemoriesRelatedSnapshotOutputFolderWithPathManager:(id)manager;
+ (void)collectMomentsStatWithLibraryContext:(id)context completionBlock:(id /* block */)block;
@end

#endif /* PLDiagnostics_h */