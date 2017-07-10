//
//  FormatMyCodesCommand.m
//  MyExtention
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  格式化代码

#import "FormatMyCodesCommand.h"

@implementation FormatMyCodesCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    NSString *identifier = invocation.commandIdentifier;
    NSLog(@"命令: %@", identifier);
    
    if ([identifier isEqualToString:@"FormatMyCodesCommandIdentifier"]) {
        [self autoGendeGetter:invocation];
    }
    completionHandler(nil);
}

- (void)autoGendeGetter:(XCSourceEditorCommandInvocation *)invocation {
    if (invocation.buffer.selections.count != 1) {
        return;
    }
    
    XCSourceTextRange *SelectedCode = invocation.buffer.selections.lastObject;
    NSInteger startLine = SelectedCode.start.line;
    NSInteger endLine = SelectedCode.end.line;
    if (startLine >= endLine) {
        return;
    }
    //1. { 换行
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSInteger n = startLine; n < endLine; n++) {
        NSString *lineCode = invocation.buffer.lines[n];
        NSLog(@">>>%zd, %@", n, lineCode);
        if ([lineCode containsString:@"{"] && ![self isOnlySpaceLine:lineCode]) {
            NSLog(@">>>%@", lineCode);
            NSString *newLine = [lineCode stringByReplacingOccurrencesOfString:@"{" withString:@""];
            if ([self isSpaceLine:newLine]) {
                [indexSet addIndex:n];
            } else {
                [invocation.buffer.lines replaceObjectAtIndex:n withObject:newLine];
            }
            NSString *preLineCode = [invocation.buffer.lines[n-1] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSString *newPreLineCode = @"";
            if ([self isEndWithSpace:preLineCode]) {
                newPreLineCode = [NSString stringWithFormat:@"%@{\n", preLineCode];
            } else {
                newPreLineCode = [NSString stringWithFormat:@"%@ {\n", preLineCode];
            }
            [invocation.buffer.lines replaceObjectAtIndex:n-1 withObject:newPreLineCode];
        } else if ([lineCode containsString:@"{"] && ![self isEndWithSpace:[lineCode stringByReplacingOccurrencesOfString:@"{\n" withString:@""]]) {
            NSString *newLineCode = [lineCode stringByReplacingOccurrencesOfString:@"{" withString:@" {"];
            [invocation.buffer.lines replaceObjectAtIndex:n withObject:newLineCode];
        }
    }
    [invocation.buffer.lines removeObjectsAtIndexes:indexSet];
}

- (BOOL)isOnlySpaceLine:(NSString *)lineCode {
    if (lineCode.length == 0) {
        return YES;
    }
    lineCode = [lineCode stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return lineCode.length > 1;
}

- (BOOL)isSpaceLine:(NSString *)lineCode {
    if (lineCode.length == 0) {
        return YES;
    }
    return [lineCode rangeOfString:@"\\w{1,}" options:NSRegularExpressionSearch].location == NSNotFound;
}

- (BOOL)isEndWithSpace:(NSString *)lineCode {
    return [lineCode rangeOfString:@"\\w+\\s$" options:NSRegularExpressionSearch].location != NSNotFound;
}

@end
