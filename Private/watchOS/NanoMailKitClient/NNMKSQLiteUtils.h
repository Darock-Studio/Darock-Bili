//
//   Generated by https://github.com/blacktop/ipsw (Version: 3.1.454, BuildTime: 2024-02-08T22:07:34Z)
//
//    - LC_BUILD_VERSION:  Platform: watchOSSimulator, MinOS: 10.2, SDK: 10.2, Tool: ld (902.8)
//    - LC_SOURCE_VERSION: 811.0.0.0.0
//
#ifndef NNMKSQLiteUtils_h
#define NNMKSQLiteUtils_h
@import Foundation;

@interface NNMKSQLiteUtils : NSObject
/* class methods */
+ (void)closeExecutedPreparedStatement:(struct sqlite3_stmt *)statement;
+ (BOOL)isResponseOkFromPreparedStatementExecution:(int)execution;
+ (void)bindString:(id)string intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindDate:(id)date intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindData:(id)data intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindInteger:(long long)integer intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindUnsignedInteger:(unsigned long long)integer intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindDouble:(double)double intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (void)bindBool:(BOOL)bool intoStatement:(struct sqlite3_stmt *)statement paramIndex:(int)index;
+ (id)stringFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (id)dateFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (id)dataFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (unsigned long long)integerFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (unsigned long long)unsignedIntegerFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (double)doubleFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
+ (BOOL)boolFromStatement:(struct sqlite3_stmt *)statement columnIndex:(int)index;
@end

#endif /* NNMKSQLiteUtils_h */