//
//
//  CodingTime.m
//  MeowBili
//
//  Created by memz233 on 2024/2/10.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
//  Copyright (c) 2024 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#import <Foundation/Foundation.h>
#import <time.h>
#import "CodingTime.h"

#define kCodingDate __DATE__
#define kCodingTime __TIME__

@implementation CodingTime

+ (NSString *) getCodingTime {
    return [@kCodingDate stringByAppendingString: [@" " stringByAppendingString: @kCodingTime]];
}

+ (long) getCodingTimestamp {
    struct tm tm_time;
    memset(&tm_time, 0, sizeof(struct tm));
    
    // 解析日期字符串
    strptime(kCodingDate, "%b %d %Y", &tm_time);
    
    // 解析时间字符串
    strptime(kCodingTime, "%H:%M:%S", &tm_time);
    
    // 将日期和时间转换为时间戳
    time_t timestamp = mktime(&tm_time);
    
    return (long)timestamp;
}

@end
