//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 491.7.0.0.0
//
#ifndef UNSKeyedDataStoreRepository_h
#define UNSKeyedDataStoreRepository_h
@import Foundation;

#include "UNSContentProtectionStrategy-Protocol.h"

@class NSString, UNCBundleLibrarian;

@interface UNSKeyedDataStoreRepository : NSObject {
  /* instance variables */
  NSString *_directory;
  NSString *_fileName;
  NSString *_pathExtension;
  UNCBundleLibrarian *_librarian;
  NSObject<UNSContentProtectionStrategy> *_protectionStrategy;
  NSString *_objectIdentifierKey;
  long long _maxObjectsPerKey;
}

/* instance methods */
- (id)initWithDirectory:(id)directory fileName:(id)name pathExtension:(id)extension librarian:(id)librarian repositoryProtectionStrategy:(id)strategy objectIdentifierKey:(id)key maxObjectsPerKey:(long long)key;
- (id)allKeys;
- (id)_directoryForKey:(id)key;
- (id)directoryPath;
- (id)_pathForKey:(id)key;
- (id)objectsForKey:(id)key;
- (id)_objectsAtPath:(id)path;
- (id)objectsPassingTest:(id /* block */)test forKey:(id)key;
- (id)_objectsPassingTest:(id /* block */)test atPath:(id)path;
- (id)_objectsForData:(id)data identifier:(id)identifier;
- (id)_dataAtPath:(id)path;
- (BOOL)_saveObjects:(id)objects atPath:(id)path;
- (void)removeAllObjectsForKey:(id)key;
- (id)removeObjectsPassingTest:(id /* block */)test forKey:(id)key;
- (id)_removeObjectsPassingTest:(id /* block */)test atPath:(id)path;
- (void)setObjects:(id)objects forKey:(id)key;
- (void)_setObjects:(id)objects atPath:(id)path;
- (id)addObject:(id)object forKey:(id)key;
- (id)replaceObject:(id)object forKey:(id)key;
- (id)addObject:(id)object mustReplace:(BOOL)replace forKey:(id)key;
- (id)_addObject:(id)object mustReplace:(BOOL)replace atPath:(id)path;
- (id)_addObject:(id)object toObjects:(id)objects mustReplace:(BOOL)replace receipt:(id *)receipt;
- (void)removeStoreForKey:(id)key;
- (void)removeDataStoreRepository;
- (void)_removeItemAtPath:(id)path;
- (void)migrateStoreAtPath:(id)path forKey:(id)key;
- (BOOL)_isReplacementSupported;
- (BOOL)_useReplacementToImport:(id)import into:(id)into;
- (void)protectionStateChanged;
@end

#endif /* UNSKeyedDataStoreRepository_h */