//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1450.2.4.0.0
//
#ifndef SSVLoadNearbyAppsOperation_h
#define SSVLoadNearbyAppsOperation_h
@import Foundation;

#include "NSOperation.h"

@class CLLocation, NSMutableDictionary, NSString;
@protocol OS_dispatch_queue;

@interface SSVLoadNearbyAppsOperation : NSOperation {
  /* instance variables */
  NSString *_baseURLString;
  NSObject<OS_dispatch_queue> *_dispatchQueue;
  NSMutableDictionary *_parameters;
}

@property (readonly) CLLocation *location;
@property (copy) NSString *pointOfInterestIdentifier;
@property (copy) NSString *pointOfInterestProviderIdentifier;
@property (copy) NSString *pointOfInterestProviderURL;
@property (copy) id /* block */ responseBlock;
@property (copy) NSString *storeFrontSuffix;
@property (copy) NSString *userAgent;

/* instance methods */
- (id)initWithBaseURL:(id)url location:(id)location;
- (void)main;
- (id)_lookupWithRequest:(id)request error:(id *)error;
- (id)_storeFrontSuffix;
@end

#endif /* SSVLoadNearbyAppsOperation_h */