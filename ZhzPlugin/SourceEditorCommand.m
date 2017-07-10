//
//  SourceEditorCommand.m
//  ZhzPlugin
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  自动生成 getter 方法

#import "SourceEditorCommand.h"

static NSString *const kUIView      = @"UIView";
static NSString *const kUITableView = @"UITableView";
static NSString *const kUIButton    = @"UIButton";
static NSString *const kUILabel     = @"UILabel";
static NSString *const kUIImageView = @"UIImageView";

@interface SourceEditorCommand ()

@property (nonatomic, assign) NSInteger line;

@end;
@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {
    NSString *identifier = invocation.commandIdentifier;
    NSLog(@"命令: %@", identifier);
    
    if ([identifier isEqualToString:@"AutoGenderGetter"]) {
        [self autoGendeGetter:invocation];
    }
    completionHandler(nil);
}

- (void)autoGendeGetter:(XCSourceEditorCommandInvocation *)invocation {
    XCSourceTextRange *selectedRange = invocation.buffer.selections.lastObject;
    NSInteger startLine = selectedRange.start.line;
    NSInteger endLine = selectedRange.end.line;
    if (startLine != endLine) {
        return;
    }
    self.line = startLine;
    NSString *lineCode = invocation.buffer.lines[startLine];
    NSLog(@"lineCode: %@", lineCode);
    
    if ([lineCode containsString:kUIView]) {
        [self genderViewGetter:(XCSourceEditorCommandInvocation *)invocation];
    } else if ([lineCode containsString:kUITableView]) {
        [self genderUITableViewGetter:(XCSourceEditorCommandInvocation *)invocation];
    } else if ([lineCode containsString:kUIButton]) {
        [self genderUIButtonGetter:(XCSourceEditorCommandInvocation *)invocation];
    } else if ([lineCode containsString:kUILabel]) {
        [self genderUILabelGetter:(XCSourceEditorCommandInvocation *)invocation];
    } else if ([lineCode containsString:kUIImageView]) {
        [self genderUIImageViewGetter:(XCSourceEditorCommandInvocation *)invocation];
    }
}

#pragma mark - UIView
- (void)genderViewGetter:(XCSourceEditorCommandInvocation *)invocation {
    
    
    
}

#pragma mark - kUITableView
- (void)genderUITableViewGetter:(XCSourceEditorCommandInvocation *)invocation {
    
}

#pragma mark - kUIButton
- (void)genderUIButtonGetter:(XCSourceEditorCommandInvocation *)invocation {
    
}

#pragma mark - kUILabel
- (void)genderUILabelGetter:(XCSourceEditorCommandInvocation *)invocation {
    
}

#pragma mark - kUIImageView
- (void)genderUIImageViewGetter:(XCSourceEditorCommandInvocation *)invocation {
    
}

- (void)insertCodeToLastLine:(NSString *)code {
    
}

- (void)objectNameWithClassName:(NSString *)className {
    
    [className rangeOfString:<#(nonnull NSString *)#>]
    
    
    
}

@end
