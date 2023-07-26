//
//  CodingTime.m
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/25.
//

#import <Foundation/Foundation.h>
#import "CodingTime.h"

#define kCodingDate __DATE__
#define kCodingTime __TIME__

@implementation CodingTime

+ (NSString *) getCodingTime {
    return [@kCodingDate stringByAppendingString: [@" " stringByAppendingString: @kCodingTime]];
}

@end
