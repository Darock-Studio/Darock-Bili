//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3302.8.1.0.0
//
#ifndef CDMServiceGraphProtoBackedCommand_h
#define CDMServiceGraphProtoBackedCommand_h
@import Foundation;

#include "CDMServiceGraphCommand.h"

@interface CDMServiceGraphProtoBackedCommand : CDMServiceGraphCommand
/* class methods */
+ (Class)innerProtoType;
+ (id)innerProtoPropertyName;
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)loggingRequestID;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* CDMServiceGraphProtoBackedCommand_h */