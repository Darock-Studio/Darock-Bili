//
//  backtrace.h
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/14.
//

#ifndef backtrace_h
#define backtrace_h

#include <mach/mach.h>

int df_backtrace(thread_t thread, void** stack, int maxSymbols);

#endif /* backtrace_h */
