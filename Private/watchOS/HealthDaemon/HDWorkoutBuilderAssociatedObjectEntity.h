//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4146.2.12.2.2
//
#ifndef HDWorkoutBuilderAssociatedObjectEntity_h
#define HDWorkoutBuilderAssociatedObjectEntity_h
@import Foundation;

#include "HDHealthEntity.h"

@interface HDWorkoutBuilderAssociatedObjectEntity : HDHealthEntity
/* class methods */
+ (long long)associateObject:(id)object timestamp:(double)timestamp withBuilder:(id)builder transaction:(id)transaction error:(id *)error;
+ (BOOL)enumerateAssociatedUUIDsForBuilder:(id)builder transaction:(id)transaction error:(id *)error block:(id /* block */)block;
+ (BOOL)removeAssociationFromBuilder:(id)builder toUUID:(id)uuid transaction:(id)transaction error:(id *)error;
+ (id)databaseTable;
+ (const struct { id x0; id x1; unsigned char x2; } *)columnDefinitionsWithCount:(unsigned long long *)count;
+ (id)foreignKeys;
+ (id)uniquedColumns;
+ (long long)protectionClass;
@end

#endif /* HDWorkoutBuilderAssociatedObjectEntity_h */