//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 170.2.3.0.0
//
#ifndef DEDTestingFinisher_h
#define DEDTestingFinisher_h
@import Foundation;

#include "DEDBugSession.h"
#include "DEDFinisher-Protocol.h"
#include "DEDSecureArchiving-Protocol.h"
#include "NSSecureCoding-Protocol.h"

@class NSString;

@interface DEDTestingFinisher : NSObject<DEDFinisher, NSSecureCoding, DEDSecureArchiving>

@property (weak) DEDBugSession *session;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (id)log;
+ (id)archivedClasses;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithConfiguration:(id)configuration session:(id)session;
- (void)finishSession:(id)session withConfiguration:(id)configuration;
- (void)encodeWithCoder:(id)coder;
- (id)initWithCoder:(id)coder;
- (id)flattenDirectories:(id)directories progressHandler:(id /* block */)handler;
- (void)writeData:(id)data filename:(id)filename;
@end

#endif /* DEDTestingFinisher_h */