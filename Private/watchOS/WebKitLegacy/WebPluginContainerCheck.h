//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 617.1.17.12.4
//
#ifndef WebPluginContainerCheck_h
#define WebPluginContainerCheck_h
@import Foundation;

#include "WebPluginContainerCheckController-Protocol.h"
#include "WebPolicyDecisionListener.h"

@class NSString, NSURLRequest;

@interface WebPluginContainerCheck : NSObject {
  /* instance variables */
  NSURLRequest *_request;
  NSString *_target;
  NSObject<WebPluginContainerCheckController> *_controller;
  id _resultObject;
  SEL _resultSelector;
  id _contextInfo;
  BOOL _done;
  WebPolicyDecisionListener *_listener;
}

/* class methods */
+ (id)checkWithRequest:(id)request target:(id)target resultObject:(id)object selector:(SEL)selector controller:(id)controller contextInfo:(id)info;

/* instance methods */
- (id)initWithRequest:(id)request target:(id)target resultObject:(id)object selector:(SEL)selector controller:(id)controller contextInfo:(id)info;
- (void)dealloc;
- (void)_continueWithPolicy:(unsigned char)policy;
- (BOOL)_isForbiddenFileLoad;
- (id)_actionInformationWithURL:(id)url;
- (void)_askPolicyDelegate;
- (void)start;
- (void)cancel;
- (id)contextInfo;
@end

#endif /* WebPluginContainerCheck_h */