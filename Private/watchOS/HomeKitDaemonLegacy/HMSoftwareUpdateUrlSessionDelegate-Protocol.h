//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1092.3.10.0.0
//
#ifndef HMSoftwareUpdateUrlSessionDelegate_Protocol_h
#define HMSoftwareUpdateUrlSessionDelegate_Protocol_h
@import Foundation;

@protocol HMSoftwareUpdateUrlSessionDelegate <NSURLSessionDelegate>
/* instance methods */
- (void)URLSession:(id)urlsession task:(id)task didCompleteWithError:(id)error;
- (void)URLSession:(id)urlsession downloadTask:(id)task didWriteData:(long long)data totalBytesWritten:(long long)written totalBytesExpectedToWrite:(long long)write;
- (void)URLSession:(id)urlsession downloadTask:(id)task didFinishDownloadingToURL:(id)url;
@end

#endif /* HMSoftwareUpdateUrlSessionDelegate_Protocol_h */