//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 4023.330.6.0.0
//
#ifndef ML3DatabaseDistantResult_h
#define ML3DatabaseDistantResult_h
@import Foundation;

#include "ML3DatabaseResult.h"
#include "ML3DatabaseDistantConnection.h"

@class NSArray, NSDictionary, NSString;

@interface ML3DatabaseDistantResult : ML3DatabaseResult {
  /* instance variables */
  NSArray *_cachedRows;
  NSDictionary *_cachedColumnNameIndexMap;
}

@property (readonly, nonatomic) ML3DatabaseDistantConnection *distantConnection;
@property (readonly, nonatomic) NSString *sql;
@property (readonly, nonatomic) NSArray *parameters;

/* instance methods */
- (id)initWithDistantConnection:(id)connection sql:(id)sql parameters:(id)parameters;
- (id)initWithStatement:(id)statement;
- (id)init;
- (id)description;
- (unsigned long long)indexForColumnName:(id)name;
- (id)columnNameIndexMap;
- (void)enumerateRowsWithBlock:(id /* block */)block;
- (void)_remoteEnumerateRowsWithBlock:(id /* block */)block;
- (void)_localEnumerateRowsWithBlock:(id /* block */)block;
- (BOOL)_fetchRowsIfEmpty;
@end

#endif /* ML3DatabaseDistantResult_h */