//
//  SourceEditorCommand.m
//  ZhzPlugin
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  自动生成 getter 方法

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
    
    NSString *identifier = invocation.commandIdentifier;
    NSLog(@"命令: %@", identifier);
    
    if ([identifier isEqualToString:@"AutoGenderGetter"]) {
        [self autoGendeGetter:invocation];
    }
    completionHandler(nil);
}

- (void)autoGendeGetter:(XCSourceEditorCommandInvocation *)invocation {
    for (NSInteger i = 0; i < invocation.buffer.lines.count; i++) {
        NSString *lineCode = invocation.buffer.lines[i];
        NSLog(@"%zd>> %@", i, lineCode);
        
    }
    
    for (NSInteger i = 0; i < invocation.buffer.selections.count; i++) {
        XCSourceTextRange *SelectedCode = invocation.buffer.selections[i];
        NSLog(@"%zd>> %@", i, SelectedCode);
        
    }
    
    
}


@end
