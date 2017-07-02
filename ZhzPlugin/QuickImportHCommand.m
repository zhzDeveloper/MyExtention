//
//  QuickImportHCommand.m
//  MyExtention
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  导入头文件
// [invocation.buffer.contentUTI containsString:@"objective-c-source"];

#import "QuickImportHCommand.h"

@implementation QuickImportHCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    
    if (invocation.buffer.selections.count != 1) {
        completionHandler(nil);
        return;
    }
    
    XCSourceTextRange *selection = invocation.buffer.selections.firstObject;
    if (selection.start.line != selection.end.line) {
        completionHandler(nil);
        return;
    }
    
    NSString *selectedString = nil;
    NSInteger lastImportLineIndex = NSNotFound;
    for (int idx = 0; idx < invocation.buffer.lines.count; idx++) {
        NSString *line = invocation.buffer.lines[idx];
        
        if ([line hasPrefix:@"#import"] || [line hasPrefix:@"@import"]) {
            lastImportLineIndex = idx;
        }
        if (idx == selection.start.line) {
            selectedString = [line substringWithRange:NSMakeRange(selection.start.column, selection.end.column - selection.start.column + 1)];
        }
    }

    NSString *trimString = [selectedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!trimString || trimString.length < 1) {
        completionHandler(nil);
        return;
    }
    
    NSString *importString = [NSString stringWithFormat:@"#import \"%@.h\"", trimString];
    if ([invocation.buffer.completeBuffer containsString:importString]) {
        completionHandler(nil);
        return;
    }
    if (lastImportLineIndex != NSNotFound) {
        [invocation.buffer.lines insertObject:importString atIndex:lastImportLineIndex+1];
    } else {
        [invocation.buffer.lines insertObject:importString atIndex:selection.start.line];
    }
    completionHandler(nil);
}

@end
