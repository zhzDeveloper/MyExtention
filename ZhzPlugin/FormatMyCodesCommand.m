//
//  FormatMyCodesCommand.m
//  MyExtention
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  格式化代码

#import "FormatMyCodesCommand.h"

@implementation FormatMyCodesCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    NSString *identifier = invocation.commandIdentifier;
    NSLog(@"命令: %@", identifier);
    
    if ([identifier isEqualToString:@"FormatMyCodesCommandIdentifier"]) {
        [self autoGendeGetter:invocation];
    }
    completionHandler(nil);
}

//TODO : 快速导入头文件

- (void)autoGendeGetter:(XCSourceEditorCommandInvocation *)invocation {
    for (NSInteger i = 0; i < invocation.buffer.selections.count; i++) {
        XCSourceTextRange *SelectedCode = invocation.buffer.selections[i];
        
        NSInteger startLine = SelectedCode.start.line;
        NSInteger endLine = SelectedCode.end.line;
        if (startLine >= endLine) {
            return;
        }
        
        //1. { 换行
        for (NSInteger n = endLine -1; n >= startLine; n--) {
            NSString *lineCode = invocation.buffer.lines[n];
            NSLog(@">>>%zd, %@", n, lineCode);
            if ([lineCode containsString:@"{"] && [[lineCode stringByReplacingOccurrencesOfString:@" " withString:@""] hasPrefix:@"{"]) {
                NSLog(@">>>%@", lineCode);
                NSString *newLine = [lineCode stringByReplacingOccurrencesOfString:@"{" withString:@""];
                if ([[newLine stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""].length > 0) {
                    [invocation.buffer.lines replaceObjectAtIndex:n withObject:newLine];
                } else {
                    [invocation.buffer.lines removeObjectAtIndex:n];
                }
                NSString *preLineCode = invocation.buffer.lines[n-1];
                NSString *newPreLineCode = newPreLineCode = [NSString stringWithFormat:@"%@ {", preLineCode];
                [invocation.buffer.lines replaceObjectAtIndex:n-1 withObject:newPreLineCode];
            }
        }
        
        //2. 属性对齐
       
    }
}

- (void)formatLineCodes:(NSMutableDictionary<NSNumber *, NSString *> *)propertyDict invocation:(XCSourceEditorCommandInvocation *)invocation {
    [propertyDict enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [invocation.buffer.lines removeObjectAtIndex:key.integerValue];
        
        
    }];
    
}

@end
