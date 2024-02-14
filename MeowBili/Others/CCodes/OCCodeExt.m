//
//
//  OCCodeExt.m
//  MeowBili
//
//  Created by memz233 on 2024/2/14.
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
#import <os/proc.h>
#import "OCCodeExt.h"

@implementation OCCodeExt: NSObject

+(double) MemAvailable {
    return os_proc_available_memory();
}

@end
