//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 1387.3.4.0.0
//
#ifndef ExportedMessageChannel_h
#define ExportedMessageChannel_h
@import Foundation;

#include "AUAudioUnitMessageChannelProtocol-Protocol.h"
#include "AUMessageChannel_XPC.h"

@interface ExportedMessageChannel : NSObject<AUAudioUnitMessageChannelProtocol> {
  /* instance variables */
  AUMessageChannel_XPC *_messageChannel;
}

/* instance methods */
- (id)initWithMessageChannel:(id)channel;
- (void)onCallRemoteAU:(id)au reply:(id /* block */)reply;
@end

#endif /* ExportedMessageChannel_h */