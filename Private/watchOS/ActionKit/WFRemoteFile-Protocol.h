//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 2206.0.5.0.0
//
#ifndef WFRemoteFile_Protocol_h
#define WFRemoteFile_Protocol_h
@import Foundation;

@protocol WFRemoteFile <WFNaming, NSCopying, NSObject>
/* instance methods */
- (BOOL)wfIsDirectory;
- (id)wfPath;
- (id)wfFileSize;
- (id)wfLastModifiedDate;
- (id)wfFileType;
- (BOOL)wfIsEqualToFile:(id)file;
@end

#endif /* WFRemoteFile_Protocol_h */