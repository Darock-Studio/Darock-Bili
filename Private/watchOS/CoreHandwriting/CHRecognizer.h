//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 445.201.0.0.0
//
#ifndef CHRecognizer_h
#define CHRecognizer_h
@import Foundation;

#include "CHCTCRecognitionModel.h"
#include "CHDrawing.h"
#include "CHMecabraWrapper.h"
#include "CHPatternNetwork.h"
#include "CHPostProcessingManager.h"
#include "CHRecognitionInsight.h"
#include "CHRecognitionInsightRequest.h"
#include "CHRecognizerConfiguration.h"
#include "CHRecognizing-Protocol.h"
#include "CHSpellChecker.h"
#include "CHStringOVSChecker.h"

@class CVNLPCTCTextDecoder, NSArray, NSCharacterSet, NSDictionary, NSLocale, NSMutableDictionary, NSMutableIndexSet, NSString, NSURL;
@protocol OS_dispatch_queue, {map<std::set<long>, std::vector<CHCandidateResult>, std::less<std::set<long>>, std::allocator<std::pair<const std::set<long>, std::vector<CHCandidateResult>>>>="__tree_"{__tree<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::__map_value_compare<std::set<long>, std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::less<std::set<long>>>, std::allocator<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>>>="__begin_node_"^v"__pair1_"{__compressed_pair<std::__tree_end_node<std::__tree_node_base<void *> *>, std::allocator<std::__tree_node<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, void *>>>="__value_"{__tree_end_node<std::__tree_node_base<void *> *>="__left_"^v}}"__pair3_"{__compressed_pair<unsigned long, std::__map_value_compare<std::set<long>, std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::less<std::set<long>>>>="__value_"Q}}}, {map<unsigned int, unsigned int, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, unsigned int>>>="__tree_"{__tree<std::__value_type<unsigned int, unsigned int>, std::__map_value_compare<unsigned int, std::__value_type<unsigned int, unsigned int>, std::less<unsigned int>>, std::allocator<std::__value_type<unsigned int, unsigned int>>>="__begin_node_"^v"__pair1_"{__compressed_pair<std::__tree_end_node<std::__tree_node_base<void *> *>, std::allocator<std::__tree_node<std::__value_type<unsigned int, unsigned int>, void *>>>="__value_"{__tree_end_node<std::__tree_node_base<void *> *>="__left_"^v}}"__pair3_"{__compressed_pair<unsigned long, std::__map_value_compare<unsigned int, std::__value_type<unsigned int, unsigned int>, std::less<unsigned int>>>="__value_"Q}}};

@interface CHRecognizer : NSObject<CHRecognizing> {
  /* instance variables */
  CHRecognitionInsightRequest *_nextRecognitionInsightRequest;
  CHRecognitionInsight *_activeRecognitionInsight;
  NSArray *_whitelistMecabraRareCharacters;
  struct CHNeuralNetwork { undefined * x0; BOOL x1; struct CHCodeMap * x2; unsigned int x3; unsigned int x4; unsigned int x5; unsigned int x6; id x7; id x8; struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } x9; } * _engine;
  struct CHNeuralNetwork { undefined * x0; BOOL x1; struct CHCodeMap * x2; unsigned int x3; unsigned int x4; unsigned int x5; unsigned int x6; id x7; id x8; struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; } x9; } * _freeformEngine;
  CHCTCRecognitionModel *_recognitionModel;
  CVNLPCTCTextDecoder *_textDecoder;
  NSObject<OS_dispatch_queue> *_recognitionQueue;
  void * _radicalClusterFST;
  void * _formatGrammarFST;
  CHPatternNetwork *_patternFST;
  CHPatternNetwork *_postProcessingFST;
  void * _lmVocabulary;
  void * _characterLanguageModel;
  void * _cjkStaticLexicon;
  void * _cjkDynamicLexicon;
  struct _LXLexicon * _secondaryStaticLexicon;
  struct _LXLexicon * _phraseLexicon;
  struct _LXLexicon * _customLexicon;
  NSMutableDictionary *_textReplacementLowercasedKeyMapping;
  NSURL *_learningDictionaryURL;
  CHDrawing *_cachedDrawing;
  struct VariantMap { int * x0; int * x1; int * x2; int x3; int * x4; unsigned long long x5; } * _transliterationVariantMap;
  void * * _icuTransliterator;
  unsigned long long _lastCharacterSegmentCount;
  NSMutableIndexSet *_lastCharacterSegmentIndexes;
  struct map<std::set<long>, std::vector<CHCandidateResult>, std::less<std::set<long>>, std::allocator<std::pair<const std::set<long>, std::vector<CHCandidateResult>>>> { struct __tree<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::__map_value_compare<std::set<long>, std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::less<std::set<long>>>, std::allocator<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>>> { void *__begin_node_; struct __compressed_pair<std::__tree_end_node<std::__tree_node_base<void *> *>, std::allocator<std::__tree_node<std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, void *>>> { struct __tree_end_node<std::__tree_node_base<void *> *> { void *__left_; } __value_; } __pair1_; struct __compressed_pair<unsigned long, std::__map_value_compare<std::set<long>, std::__value_type<std::set<long>, std::vector<CHCandidateResult>>, std::less<std::set<long>>>> { unsigned long long __value_; } __pair3_; } __tree_; } _cachedResults;
  struct map<unsigned int, unsigned int, std::less<unsigned int>, std::allocator<std::pair<const unsigned int, unsigned int>>> { struct __tree<std::__value_type<unsigned int, unsigned int>, std::__map_value_compare<unsigned int, std::__value_type<unsigned int, unsigned int>, std::less<unsigned int>>, std::allocator<std::__value_type<unsigned int, unsigned int>>> { void *__begin_node_; struct __compressed_pair<std::__tree_end_node<std::__tree_node_base<void *> *>, std::allocator<std::__tree_node<std::__value_type<unsigned int, unsigned int>, void *>>> { struct __tree_end_node<std::__tree_node_base<void *> *> { void *__left_; } __value_; } __pair1_; struct __compressed_pair<unsigned long, std::__map_value_compare<unsigned int, std::__value_type<unsigned int, unsigned int>, std::less<unsigned int>>> { unsigned long long __value_; } __pair3_; } __tree_; } _characterIDMap;
}

@property (readonly, nonatomic) CHRecognitionInsight *recordedInsightFromLastRequest;
@property (retain, nonatomic) CHSpellChecker *spellChecker;
@property (nonatomic) struct _LXLexicon * customPhraseLexicon;
@property (retain, nonatomic) NSDictionary *textReplacements;
@property (retain, nonatomic) CHPostProcessingManager *postProcessor;
@property (retain, nonatomic) CHPostProcessingManager *mergedResultPostProcessor;
@property (retain, nonatomic) CHRecognizerConfiguration *configuration;
@property (retain, nonatomic) CHMecabraWrapper *mecabraWrapper;
@property (nonatomic) struct _LXLexicon * staticLexicon;
@property (nonatomic) void * wordLanguageModel;
@property (retain, nonatomic) CHStringOVSChecker *ovsStringChecker;
@property (nonatomic) int recognitionMode;
@property (copy, nonatomic) NSLocale *locale;
@property (nonatomic) int recognitionType;
@property (nonatomic) BOOL enableCachingIfAvailable;
@property (nonatomic) BOOL enableGen2ModelIfAvailable;
@property (nonatomic) BOOL enableGen2CharacterLMIfAvailable;
@property (nonatomic) int contentType;
@property (nonatomic) int autoCapitalizationMode;
@property (nonatomic) int autoCorrectionMode;
@property (nonatomic) int baseWritingDirection;
@property (nonatomic) unsigned long long maxRecognitionResultCount;
@property (retain, nonatomic) NSCharacterSet *activeCharacterSet;
@property (nonatomic) struct CGSize { double x0; double x1; } minimumDrawingSize;
@property (readonly) unsigned long long hash;
@property (readonly) Class superclass;
@property (readonly, copy) NSString *description;
@property (readonly, copy) NSString *debugDescription;

/* class methods */
+ (BOOL)isLocaleSupported:(id)supported withMode:(int)mode;
+ (void)_updatePrecedingAndTrailingSeparatorsForTopCandidate:(id)candidate history:(id)history textAfter:(id)after locale:(id)locale outTrailingSeparator:(id *)separator inFirstTokenHasPrecedingSpace:(BOOL)space outFirstTokenHasPrecedingSpace:(BOOL *)space;

/* instance methods */
- (void)recordInsightWithRequest:(id)request;
- (id)initWithType:(int)type mode:(int)mode locale:(struct __CFLocale *)locale learningDictionaryURL:(id)url;
- (id)initWithMode:(int)mode locale:(id)locale;
- (id)initWithMode:(int)mode locale:(id)locale recognizerOptions:(id)options;
- (id)initWithMode:(int)mode locale:(id)locale learningDictionaryURL:(id)url;
- (id)initWithMode:(int)mode locale:(id)locale learningDictionaryURL:(id)url recognizerOptions:(id)options;
- (id)initWithType:(int)type mode:(int)mode learningDictionaryURL:(id)url;
- (id)strokeIndexesForLastCharacter;
- (id)_defaultPunctuationStringsOutputScores:(id *)scores maxCandidateCount:(long long)count;
- (BOOL)isOVSString:(id)ovsstring;
- (id)transliterationVariantsForString:(id)string;
- (void)_initializeMergedResultPostProcessor;
- (BOOL)_isLocaleSupported:(id)supported;
- (void)updateAddressBookLexicon:(id)lexicon;
- (void)updateUserDictionaryLexicon:(id)lexicon;
- (void)updateMecabraWithRegionalOTAAssets:(id)otaassets nonRegionalOTAAssets:(id)otaassets;
- (void)setCustomLexicon:(struct _LXLexicon *)lexicon customVocabulary:(void *)vocabulary;
- (void)_updateWordLanguageModel:(void *)model;
- (void)candidateAccepted:(void *)accepted;
- (struct vector<const void *, std::allocator<const void *>> { void * * x0; void * * x1; struct __compressed_pair<const void **, std::allocator<const void *>> { void * * x0; } x2; })completionsForCandidate:(id)candidate prefix:(id)prefix option:(unsigned long long)option;
- (struct vector<const void *, std::allocator<const void *>> { void * * x0; void * * x1; struct __compressed_pair<const void **, std::allocator<const void *>> { void * * x0; } x2; })completionsForCandidate:(id)candidate candidateContext:(id)context prefix:(id)prefix option:(unsigned long long)option;
- (BOOL)isRareChineseEntry:(id)entry;
- (id)initWithType:(int)type mode:(int)mode;
- (id)initWithType:(int)type mode:(int)mode locale:(struct __CFLocale *)locale;
- (void)dealloc;
- (id)supportedCharacterSet;
- (id)supportedStrings;
- (id)characterSetForStrings:(id)strings;
- (double)_calculateJointWordLMScoreForString:(id)string wordRanges:(id)ranges wordIDs:(id)ids patternEntries:(id)entries history:(unsigned int *)history historyLength:(unsigned long long)length;
- (id)_tokensUsingLMTokenizerForString:(id)string wordRanges:(id)ranges nonWordPatterns:(id)patterns outTokenIDs:(id *)ids;
- (id)_addAlternativeCandidatesForTokenizedResult:(id)result;
- (void)_adjustResultsForConfusableCharacters:(id)characters;
- (id)_tokenFromLegacyResult:(id)result wordIndex:(unsigned long long)index strokeSet:(id)set substrokeCount:(long long)count;
- (id)bestTranscriptionPathsForTokenizedResult:(id)result scores:(id *)scores history:(id)history;
- (void)_calculateBestTranscriptionPaths:(id *)paths scores:(id *)scores fromTokenizedResult:(id)result pathCount:(long long)count history:(id)history skipLMRescoring:(BOOL)lmrescoring;
- (id)_contextTokenIDsFromHistory:(id)history maxCharacterLength:(unsigned long long)length maxTokenCount:(unsigned long long)count;
- (id)_tokenizedTextResultFromResults:(id)results segmentGroup:(id)group offsetSegment:(long long)segment decodedStrokeSets:(BOOL)sets spaceBehavior:(long long)behavior;
- (id)_resultUsingNextGenerationPipelineWithDrawing:(id)drawing options:(id)options;
- (id)recognitionEngineCachingKey;
- (id)_postprocessingMergedRecognitionResult:(id)result options:(id)options;
- (id)_changeableColumnCountUpdatedResult:(id)result options:(id)options;
- (id)textRecognitionResultForDrawing:(id)drawing options:(id)options shouldCancel:(id /* block */)cancel;
- (id)textRecognitionResultForDrawing:(id)drawing options:(id)options writingStatistics:(id)statistics shouldCancel:(id /* block */)cancel;
- (id)recognitionResultsForDrawing:(id)drawing options:(id)options shouldCancel:(id /* block */)cancel;
- (id)recognitionResultsForDrawing:(id)drawing options:(id)options;
- (void)_adjustCandidatesForConfusableCharacters:(void *)characters;
- (id)_applySentenceTransliterationCandidates:(unsigned short *)candidates codesLen:(int)len codesMax:(int)max;
- (void)_applyTransliterationAndSyntheticCandidates:(void *)candidates;
- (void)_rescoreCandidatesWithLanguageModel:(void *)model history:(id)history;
- (unsigned long long)_effectiveMaxRecognitionResultCount;
- (void)_setConfiguration:(id)configuration;
@end

#endif /* CHRecognizer_h */