//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 866.4.0.0.0
//
#ifndef CUICatalog_h
#define CUICatalog_h
@import Foundation;

@class NSArray, NSBundle, NSCache, NSDictionary, NSMapTable, NSString;

@interface CUICatalog : NSObject {
  /* instance variables */
  NSMapTable *_storageMapTable;
  NSBundle *_bundle;
  NSString *_assetStoreName;
  NSCache *_lookupCache;
  NSCache *_negativeCache;
  NSCache *_localObjectCache;
  NSDictionary *_vibrantColorMatrixTints;
  NSArray *_assetCatalogLocalizations;
  unsigned short _preferredLocalization;
  unsigned int x :1 _purgeWhenFinished;
  unsigned int x :2 _fileHasDisplayGamutInKeySpace;
  unsigned int x :28 _reserved;
}

@property (nonatomic) unsigned long long storageRef;

/* class methods */
+ (BOOL)isValidLCRWithBytes:(const void *)bytes length:(unsigned long long)length;
+ (BOOL)isValidAssetStorageWithURL:(id)url;
+ (id)defaultUICatalogForBundle:(id)bundle;
+ (id)bestMatchUsingObjects:(id)objects getAttributeValueUsing:(id /* block */)using scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut deploymentTarget:(long long)target layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(long long)class graphicsFeatureSetClass:(long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
+ (id)bestMatchUsingObjects:(id)objects getAttributeValueUsing:(id /* block */)using scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut deploymentTarget:(long long)target layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(long long)class graphicsFeatureSetClass:(long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order platform:(long long)platform;
+ (id)bestMatchUsingImages:(id)images scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype;
+ (id)bestMatchUsingImages:(id)images scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
+ (id)bestMatchUsingImages:(id)images scaleFactor:(double)factor deviceIdiom:(long long)idiom displayGamut:(unsigned long long)gamut deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
+ (id)bestMatchUsingImages:(id)images scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(unsigned long long)gamut layoutDirection:(unsigned long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
+ (struct CGColor *)newColorByAdjustingLightnessOfColor:(struct CGColor *)color darker:(BOOL)darker;

/* instance methods */
- (id)initWithName:(id)name fromBundle:(id)bundle;
- (void)_setPreferredLocalization:(id)localization;
- (id)_nameForLocalizationIdentifier:(long long)identifier;
- (id)initWithName:(id)name fromBundle:(id)bundle error:(id *)error;
- (id)initWithURL:(id)url error:(id *)error;
- (id)initWithBytes:(const void *)bytes length:(unsigned long long)length error:(id *)error;
- (void)dealloc;
- (void)_resourceUnPinnedNotification:(id)notification;
- (id)_recognitionImageWithName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor;
- (id)imageWithName:(id)name scaleFactor:(double)factor locale:(id)locale;
- (id)imageWithName:(id)name scaleFactor:(double)factor appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction;
- (id)imageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction appearanceName:(id)name locale:(id)locale;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(long long)class graphicsClass:(long long)class;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name locale:(id)locale;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)_baseImageKeyForName:(id)name;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom layoutDirection:(long long)direction locale:(id)locale adjustRenditionKeyWithBlock:(id /* block */)block;
- (id)_imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class appearanceIdentifier:(long long)identifier graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order locale:(id)locale;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class appearanceIdentifier:(long long)identifier graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)imageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class appearanceIdentifier:(long long)identifier graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order locale:(id)locale;
- (id)iconImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical desiredSize:(struct CGSize { double x0; double x1; })size;
- (id)iconImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical desiredSize:(struct CGSize { double x0; double x1; })size appearanceName:(id)name;
- (BOOL)imageExistsWithName:(id)name;
- (BOOL)imageExistsWithName:(id)name scaleFactor:(double)factor;
- (id)_dataWithName:(id)name deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class appearanceIdentifier:(long long)identifier graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)dataWithName:(id)name deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class appearanceIdentifier:(long long)identifier graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)dataWithName:(id)name deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)dataWithName:(id)name;
- (id)dataWithName:(id)name appearanceName:(id)name;
- (id)textStyleWithName:(id)name deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)textStyleWithName:(id)name deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name;
- (id)textStyleWithName:(id)name displayGamut:(long long)gamut;
- (id)textStyleWithName:(id)name displayGamut:(long long)gamut appearanceName:(id)name;
- (id)_namedImageAtlasWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom displayGamut:(long long)gamut deviceSubtype:(unsigned long long)subtype memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)namedImageAtlasWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom displayGamut:(long long)gamut deviceSubtype:(unsigned long long)subtype memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order;
- (id)namedImageAtlasWithName:(id)name scaleFactor:(double)factor;
- (id)namedImageAtlasWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom;
- (id)namedImageAtlasWithName:(id)name scaleFactor:(double)factor displayGamut:(unsigned long long)gamut;
- (id)parentNamedImageAtlasForImageNamed:(id)named scaleFactor:(double)factor displayGamut:(unsigned long long)gamut;
- (id)parentNamedImageAtlastForImageNamed:(id)named scaleFactor:(double)factor;
- (void)preloadNamedAtlasWithScaleFactor:(double)factor andNames:(id)names completionHandler:(id /* block */)handler;
- (id)_baseVectorGlyphForName:(id)name;
- (id)namedVectorGlyphWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom glyphSize:(long long)size glyphWeight:(long long)weight glyphPointSize:(double)size appearanceName:(id)name;
- (id)namedVectorGlyphWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom layoutDirection:(long long)direction glyphSize:(long long)size glyphWeight:(long long)weight glyphPointSize:(double)size appearanceName:(id)name;
- (id)namedVectorGlyphWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom layoutDirection:(long long)direction glyphSize:(long long)size glyphWeight:(long long)weight glyphPointSize:(double)size appearanceName:(id)name locale:(id)locale;
- (id)allImageNames;
- (id)imagesWithName:(id)name;
- (BOOL)containsLookupForName:(id)name;
- (void)enumerateNamedLookupsUsingBlock:(id /* block */)block;
- (struct CGPDFDocument *)pdfDocumentWithName:(id)name;
- (struct CGPDFDocument *)pdfDocumentWithName:(id)name appearanceName:(id)name;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction appearanceName:(id)name;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut layoutDirection:(long long)direction appearanceName:(id)name locale:(id)locale;
- (id)_baseVectorRenditionKey:(id)key;
- (id)_namedVectorImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceIdentifier:(long long)identifier locale:(id)locale;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name;
- (id)namedVectorImageWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name locale:(id)locale;
- (id)layerStackWithName:(id)name;
- (id)layerStackWithName:(id)name scaleFactor:(double)factor;
- (id)layerStackWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom;
- (id)_layerStackWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)layerStackWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)_defaultLayerStackWithScaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)defaultLayerStackWithScaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)_defaultNamedAssetWithScaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)defaultNamedAssetWithScaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)namedLookupWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)_namedLookupWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name locale:(id)locale;
- (id)namedLookupWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical;
- (id)namedLookupWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name;
- (id)namedLookupWithName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical appearanceName:(id)name locale:(id)locale;
- (id)namedLookupWithName:(id)name scaleFactor:(double)factor;
- (id)_baseTextureKeyForName:(id)name;
- (id)_namedTextureWithName:(id)name scaleFactor:(double)factor appearanceName:(id)name;
- (id)namedTextureWithName:(id)name scaleFactor:(double)factor appearanceName:(id)name;
- (id)namedTextureWithName:(id)name scaleFactor:(double)factor;
- (id)_namedTextureWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut appearanceName:(id)name;
- (id)namedTextureWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut appearanceName:(id)name;
- (id)namedTextureWithName:(id)name scaleFactor:(double)factor displayGamut:(long long)gamut;
- (id)iconImageWithName:(id)name scaleFactor:(double)factor displayGamut:(unsigned long long)gamut layoutDirection:(long long)direction desiredSize:(struct CGSize { double x0; double x1; })size;
- (id)iconImageWithName:(id)name scaleFactor:(double)factor displayGamut:(unsigned long long)gamut layoutDirection:(long long)direction desiredSize:(struct CGSize { double x0; double x1; })size appearanceName:(id)name;
- (id)_baseColorKeyForName:(id)name;
- (id)colorWithName:(id)name displayGamut:(long long)gamut deviceIdiom:(long long)idiom appearanceName:(id)name;
- (id)colorWithName:(id)name displayGamut:(long long)gamut deviceIdiom:(long long)idiom;
- (id)colorWithName:(id)name displayGamut:(long long)gamut appearanceName:(id)name;
- (id)colorWithName:(id)name displayGamut:(long long)gamut;
- (id)_baseModelForKeyForName:(id)name;
- (id)_modelWithName:(id)name;
- (id)modelWithName:(id)name;
- (id)_baseRecognitionGroupImageSetKeyForName:(id)name;
- (id)namedRecognitionGroupWithName:(id)name;
- (id)_baseRecognitionObjectKeyForName:(id)name;
- (id)_recognitionObjectWithName:(id)name;
- (unsigned long long)_storageRefForRendition:(id)rendition representsODRContent:(BOOL *)odrcontent;
- (unsigned long long)_themeRef;
- (id)_themeStore;
- (id)_baseKeyForName:(id)name;
- (id)_baseAtlasKeyForName:(id)name;
- (id)_baseAtlasContentsKeyForName:(id)name;
- (id)_defaultAssetRenditionKey:(id)key;
- (id)_baseMultisizeImageSetKeyForName:(id)name;
- (id)appearanceNames;
- (id)_nameForAppearanceIdentifier:(long long)identifier;
- (id)_resolvedRenditionKeyForName:(id)name scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order locale:(id)locale withBaseKeySelector:(SEL)selector adjustRenditionKeyWithBlock:(id /* block */)block;
- (id)_resolvedRenditionKeyFromThemeRef:(unsigned long long)ref withBaseKey:(id)key scaleFactor:(double)factor deviceIdiom:(long long)idiom deviceSubtype:(unsigned long long)subtype displayGamut:(long long)gamut layoutDirection:(long long)direction sizeClassHorizontal:(long long)horizontal sizeClassVertical:(long long)vertical memoryClass:(unsigned long long)class graphicsClass:(unsigned long long)class graphicsFallBackOrder:(id)order deviceSubtypeFallBackOrder:(id)order locale:(id)locale adjustRenditionKeyWithBlock:(id /* block */)block;
- (id)newShapeEffectPresetWithRenditionKey:(id)key;
- (BOOL)canGetShapeEffectRenditionWithKey:(id)key;
- (id)renditionKeyForShapeEffectPresetWithStyleID:(unsigned long long)id state:(long long)state presentationState:(long long)state value:(long long)value resolution:(unsigned long long)resolution dimension1:(unsigned long long)dimension1;
- (id)renditionKeyForShapeEffectPresetWithStylePresetName:(id)name state:(long long)state presentationState:(long long)state value:(long long)value resolution:(unsigned long long)resolution dimension1:(unsigned long long)dimension1 appearance:(long long)appearance;
- (BOOL)_effectStyle:(unsigned long long *)style state:(long long *)state presentationState:(long long *)state value:(long long *)value resolution:(unsigned long long *)resolution dimension1:(unsigned long long *)dimension1 appearance:(long long *)appearance fromStyleConfiguration:(id)configuration;
- (id)renditionKeyForShapeEffectPresetForStylePresetName:(id)name styleConfiguration:(id)configuration;
- (id)newShapeEffectPresetForStylePresetName:(id)name styleConfiguration:(id)configuration;
- (id)newTextEffectStackForStylePresetName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color;
- (id)newShapeEffectStackForStylePresetName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color;
- (BOOL)drawGlyphs:(const unsigned short *)glyphs atPositions:(const struct CGPoint { double x0; double x1; } *)positions inContext:(struct CGContext *)context withFont:(struct __CTFont *)font count:(unsigned long long)count stylePresetName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color;
- (BOOL)_doStyledQuartzDrawingInContext:(struct CGContext *)context inBounds:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })bounds stylePresetName:(id)name styleConfiguration:(id)configuration drawingHandler:(id /* block */)handler;
- (BOOL)strokeStyledPath:(struct CGPath *)path inContext:(struct CGContext *)context stylePresetName:(id)name styleConfiguration:(id)configuration;
- (BOOL)fillStyledPath:(struct CGPath *)path inContext:(struct CGContext *)context stylePresetName:(id)name styleConfiguration:(id)configuration;
- (BOOL)fillStyledRect:(struct CGRect { struct CGPoint { double x0; double x1; } x0; struct CGSize { double x0; double x1; } x1; })rect inContext:(struct CGContext *)context stylePresetName:(id)name styleConfiguration:(id)configuration;
- (BOOL)hasStylePresetWithName:(id)name styleConfiguration:(id)configuration;
- (BOOL)hasStylePresetWithName:(id)name;
- (struct CGColor *)equivalentForegroundColorForStylePresetWithName:(id)name styleConfiguration:(id)configuration;
- (struct CGColor *)equivalentForegroundColorForStylePresetWithName:(id)name styleConfiguration:(id)configuration baseForegroundColor:(struct CGColor *)color;
- (int)blendModeForStylePresetWithName:(id)name styleConfiguration:(id)configuration;
- (void)_vibrantColorMatrixBrightnessSaturationForColor:(struct CGColor *)color saturation:(double *)saturation brightness:(double *)brightness;
- (id)compositingFilterForStylePresetWithName:(id)name styleConfiguration:(id)configuration;
- (id)compositingFilterForStylePresetWithName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color;
- (struct { double x0; double x1; double x2; double x3; })styledInsetsForStylePresetName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color scale:(double)scale;
- (id)imageByStylingImage:(struct CGImage *)image stylePresetName:(id)name styleConfiguration:(id)configuration foregroundColor:(struct CGColor *)color scale:(double)scale;
- (id)debugDescription;
- (void)clearCachedImageResources;
- (id)lookupCache;
- (id)negativeCache;
- (id)localObjectCache;
@end

#endif /* CUICatalog_h */