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
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#import <Foundation/Foundation.h>
#import "CodingTime.h"

#define kCodingDate __DATE__
#define kCodingTime __TIME__

@implementation CodingTime

+ (NSString *) getCodingTime {
    return [@kCodingDate stringByAppendingString: [@" " stringByAppendingString: @kCodingTime]];
}

@end
