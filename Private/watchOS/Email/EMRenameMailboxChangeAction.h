//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EMRenameMailboxChangeAction_h
#define EMRenameMailboxChangeAction_h
@import Foundation;

#include "EMMailboxChangeAction.h"

@class NSString;

@interface EMRenameMailboxChangeAction : EMMailboxChangeAction

@property (readonly, copy, nonatomic) NSString *name;

/* class methods */
+ (BOOL)supportsSecureCoding;

/* instance methods */
- (id)initWithMailbox:(id)mailbox newName:(id)name;
- (id)initWithMailboxObjectID:(id)id newName:(id)name;
- (id)initWithCoder:(id)coder;
- (void)encodeWithCoder:(id)coder;
@end

#endif /* EMRenameMailboxChangeAction_h */