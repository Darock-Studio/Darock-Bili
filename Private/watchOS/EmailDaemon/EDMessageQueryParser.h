//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EDMessageQueryParser_h
#define EDMessageQueryParser_h
@import Foundation;

#include "EDMessageQueryTransformer.h"

@class EFSQLObjectPropertyMapper;
@protocol EFSQLValueExpressable;

@interface EDMessageQueryParser : NSObject

@property (readonly, nonatomic) EDMessageQueryTransformer *transformer;
@property (readonly, nonatomic) NSObject<EFSQLValueExpressable> *additionalSQLClause;
@property (readonly, nonatomic) NSObject<EFSQLValueExpressable> *additionalSQLClauseForCountQuery;
@property (readonly, nonatomic) NSObject<EFSQLValueExpressable> *additionalSQLClauseForGlobalMessageCountQuery;
@property (readonly, nonatomic) NSObject<EFSQLValueExpressable> *additionalSQLClauseForJournaledMessages;
@property (readonly, nonatomic) EFSQLObjectPropertyMapper *sqlPropertyMapper;

/* class methods */
+ (id)log;

/* instance methods */
- (id)initWithSchema:(id)schema protectedSchema:(id)schema accountsProvider:(id)provider vipManager:(id)manager messagePersistence:(id)persistence mailboxPersistence:(id)persistence;
- (void)_modifySelectStatement:(id)statement byAddingAdditionalClause:(id)clause;
- (id)sqlQueryForQuery:(id)query protectedDataAvailable:(BOOL)available;
- (id)_sqlQueryToCountResultsForQuery:(id)query distinctByGlobalMessageID:(BOOL)id;
- (id)sqlQueryToCountJournaledMessagesForQuery:(id)query;
- (id)sqlCountQueryForQuery:(id)query;
- (id)sqlQueryToCountMessagesWithGlobalMessageID:(long long)id matchingQuery:(id)query;
@end

#endif /* EDMessageQueryParser_h */