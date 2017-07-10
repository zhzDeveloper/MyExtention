//
//  FormatPropertyListCommand.m
//  ZhzPlugin
//
//  Created by zhz on 05/07/2017.
//  Copyright © 2017 zhz. All rights reserved.
//

#import "FormatPropertyListCommand.h"

@implementation FormatPropertyListCommand
- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    if ([invocation.commandIdentifier isEqualToString:@"FormatPropertyListIdentifier"]) {
        if (invocation.buffer.selections.count != 1) {
            return;
        }
        XCSourceTextRange *selectedRange = invocation.buffer.selections.lastObject;
        NSInteger startLine = selectedRange.start.line;
        NSInteger endLine = selectedRange.end.line;
        if (startLine == endLine) {
            return;
        }
        for (NSInteger i = startLine; i < endLine; i++) {
            NSString *lineCode = invocation.buffer.lines[i];
            if (![lineCode containsString:@"@property"]) {
                continue;
            }
            //( , ) *
            if ([self locationIndex:@"(" charString:lineCode] != NSNotFound) {
                NSArray *ar = [lineCode componentsSeparatedByString:@"("];
                if (ar.count > 2) {
                    return;
                }
                lineCode = [NSString stringWithFormat:@"%@ (%@", [ar.firstObject stringByReplacingOccurrencesOfString:@" " withString:@""], [ar.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            }
            if ([self locationIndex:@"," charString:lineCode] != NSNotFound) {
                NSArray *ar = [lineCode componentsSeparatedByString:@","];
                if (ar.count > 2) {
                    return;
                }
                lineCode = [NSString stringWithFormat:@"%@, %@", [ar.firstObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]], [ar.lastObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            }
            [invocation.buffer.lines replaceObjectAtIndex:i withObject:lineCode];
        }
    }
    completionHandler(nil);
}

- (NSInteger)locationIndex:(NSString *)charString charString:(NSString *)lineCode {
    return [lineCode rangeOfString:charString].location;
}

@end
