//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 435.201.0.0.0
//
#ifndef NSLocale_Setup_h
#define NSLocale_Setup_h
@import Foundation;

@interface NSLocale (Setup)
/* class methods */
+ (BOOL)_language:(id)_language usesSameLocalizationAs:(id)as;
+ (id)canonicalLocaleIdentifier:(id)identifier withNewLanguageIdentifier:(id)identifier;
+ (id)_localeIdentifierForRegionChangeFrom:(id)from to:(id)to;
+ (id)localeIdentifierForRegionChange:(id)change;
+ (id)deviceLanguageLocale;
+ (id)deviceLanguageIdentifier;
+ (id)supportedCJLanguageIdentifiers;
+ (id)canonicalLanguageAndScriptCodeIdentifierForIdentifier:(id)identifier;
+ (id)canonicalLocaleIdentifierFromComponents:(id)components;
+ (id)addLikelySubtagsForLocaleIdentifier:(id)identifier;
+ (id)renderableUILanguages;
+ (id)renderableLocaleLanguages;
+ (id)renderableLanguagesFromList:(id)list;
+ (void)setLocaleOnly:(id)only;
+ (void)setLocaleAndResetTimeFormat:(id)format;
+ (void)resetTimeFormat;
+ (void)setLocaleAndResetCustomFormat:(id)format;
+ (void)resetCustomFormats;
+ (id)validateLocale:(id)locale;
+ (void)setLocaleAfterLanguageChange:(id)change;
+ (void)_insertFallbackLanguageIfNecessaryForRegion:(id)region;
+ (void)setLocaleAfterRegionChange:(id)change;
+ (id)canonicalLocaleIdentifierWithValidCalendarForComponents:(id)components;
+ (id)languageArrayAfterSettingLanguage:(id)language fallback:(id)fallback toLanguageArray:(id)array;
+ (void)setPreferredLanguageAndUpdateLocale:(id)locale;
+ (void)setLanguageToPreferredLanguages:(id)languages fallback:(id)fallback;
+ (id)_preferencesForSetLanguageAndRegion:(id)region;
+ (void)setLanguageAndRegion:(id)region;
+ (BOOL)_usesTwelveHourClock;
+ (BOOL)_usesTwelveHourClockForLoginWindow;
+ (BOOL)_defaultUsesTwelveHourClockForLocaleIdentifier:(id)identifier;
+ (void)_setUsesTwelveHourClock:(BOOL)clock;
+ (void)_setUsesTwelveHourClockForLoginWindow:(BOOL)window;
+ (id)_languageIdentifiersForLanguage:(id)language region:(id)region;
+ (id)_localeIdentifierForLanguage:(id)language region:(id)region;
+ (void)enableDefaultKeyboardForPreferredLanguages;
+ (id)_sanitizedLanguageIdentifierFromKeyboardLanguage:(id)language;
+ (id)_sanitizedLanguageIdentifierFromKeyboardLanguage:(id)language currentLocale:(id)locale;
+ (void)registerPreferredLanguageForAddedKeyboardLanguage:(id)language;
+ (void)unregisterPreferredLanguageForKeyboardLanguage:(id)language;
+ (id)archivedPreferences;
+ (id)archivedPreferencesForTargetPlatform:(unsigned long long)platform;
+ (id)archivedPreferencesWithHash:(out id *)hash;
+ (id)_archivedPreferencesWithOverridingLanguages:(id)languages targetPlatform:(unsigned long long)platform hash:(out id *)hash;
+ (id)_hashesFromAppPreferences:(id)preferences;
+ (void)archivedPreferencesWithHashesForBundleIDs:(id)ids reply:(id /* block */)reply;
+ (id)archivedPreferencesWithHashesForBundleIDs:(id)ids;
+ (void)setArchivedPreferences:(id)preferences;
+ (id)displayNameForSelectableScriptCode:(id)code;
+ (id)_subdivisionCodeFromSubdivisionTag:(id)tag restrictedToRegionCode:(id)code;

/* instance methods */
- (id)localeByChangingLanguageTo:(id)to;
- (id)selectableScriptCodes;
- (id)optionNameForSelectableScripts;
- (id)optionNameWithColonForSelectableScripts;
- (id)explanationTextForSelectableScripts;
- (BOOL)_requiresMultilingualSetupWithKeyboardIDs:(id)ids;
- (BOOL)requiresMultilingualSetup;
- (id)_languagesForMultilingualSetupWithKeyboardsIDs:(id)ids;
- (id)languagesForMultilingualSetup;
- (id)defaultLanguagesForMultilingualSetup;
@end

#endif /* NSLocale_Setup_h */