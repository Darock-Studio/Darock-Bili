//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 3774.300.42.0.0
//
#ifndef EMQueryResultsObserver_Protocol_h
#define EMQueryResultsObserver_Protocol_h
@import Foundation;

@protocol EMQueryResultsObserver <EMObject>
/* instance methods */
- (void)queryDidStartRecovery;
- (void)queryMatchedAddedObjectIDs:(id)ids before:(id)before extraInfo:(id)info;
- (void)queryMatchedAddedObjectIDs:(id)ids after:(id)after extraInfo:(id)info;
- (void)queryMatchedMovedObjectIDs:(id)ids before:(id)before;
- (void)queryMatchedMovedObjectIDs:(id)ids after:(id)after;
- (void)queryMatchedChangesByObjectIDs:(id)ids;
- (void)queryAnticipatesDeletedObjectIDs:(id)ids;
- (void)queryMatchedDeletedObjectIDs:(id)ids;
- (void)queryDidFinishInitialLoad;
- (void)queryDidFinishRemoteSearch;
- (BOOL)observerContainsObjectID:(id)id;
- (void)queryReplacedObjectID:(id)id withNewObjectID:(id)id;
@end

#endif /* EMQueryResultsObserver_Protocol_h */