//
//
//  backtrace.h
//  DarockBili
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

#ifndef backtrace_h
#define backtrace_h

#include <mach/mach.h>

int df_backtrace(thread_t thread, void** stack, int maxSymbols);

#endif /* backtrace_h */
