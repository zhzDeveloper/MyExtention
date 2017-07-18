//
//  SourceEditorCommand.m
//  ZhzPlugin
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//  自动生成 getter 方法

#import "SourceEditorCommand.h"

static NSString *const kUIView              = @"UIView";
static NSString *const kUITableView         = @"UITableView";
static NSString *const kUIButton            = @"UIButton";
static NSString *const kUILabel             = @"UILabel";
static NSString *const kUIImageView         = @"UIImageView";
static NSString *const kYYAnimatedImageView = @"YYAnimatedImageView";

@interface SourceEditorCommand ()

@property (nonatomic, strong) NSString *className;

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
    if (invocation.buffer.selections.count != 1) {
        return;
    }
    XCSourceTextRange *selectedRange = invocation.buffer.selections.lastObject;
    NSInteger startLine = selectedRange.start.line;
    NSInteger endLine = selectedRange.end.line;
    
    for (NSInteger i = startLine; i <= endLine; i++) {
        NSString *lineCode = invocation.buffer.lines[i];
        if (![lineCode containsString:@"@property"]) {
            continue;
        }
        NSLog(@"lineCode: %@", lineCode);
        NSString *className = [self objectNameWithClassName:lineCode];
        if (className.length == 0) {
            return;
        }
        self.className = className;
        NSInteger lastLine = [self lastEnd:invocation];
        if (lastLine == NSNotFound) {
            return;
        }
        
        NSString *getterCode = @"";
        if ([lineCode containsString:kUIView]) {
            getterCode = [self genderViewGetter];
        } else if ([lineCode containsString:kUITableView]) {
            getterCode = [self genderUITableViewGetter];
        } else if ([lineCode containsString:kUIButton]) {
            getterCode = [self genderUIButtonGetter];
        } else if ([lineCode containsString:kUILabel]) {
            getterCode = [self genderUILabelGetter];
        } else if ([lineCode containsString:kUIImageView]) {
            getterCode = [self genderUIImageViewGetter];
        } else if ([lineCode containsString:kYYAnimatedImageView]) {
            getterCode = [self genderYYAnimatedImageViewGetter];
        } else {
            NSString *className = [self classNameWithLineCode:lineCode];
            getterCode = [self genderPublicClassGetter:className];
        }
        if (getterCode.length == 0) {
            return;
        }
        [invocation.buffer.lines insertObject:getterCode atIndex:lastLine];
    }
}

#pragma mark - UIView
- (NSString *)genderViewGetter {
    return [NSString stringWithFormat:@"- (UIView *)%@ {\n\tif (!_%@) {\n\t\t_%@ = [[UIView alloc] init];\n\t\t_%@.backgroundColor = [UIColor redColor];\n\t}\n\treturn _%@;\n}\n\n", self.className, self.className, self.className, self.className, self.className] ;
}

#pragma mark - kUITableView
- (NSString *)genderUITableViewGetter {
    return [NSString stringWithFormat:@"- (UITableView *)%@ {\n\tif (!_%@) {\n\t\t_%@ = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];\n\t\t_%@.dataSource = self;\n\t\t_%@.delegate = self;\n\t\t[_%@ setTableFooterView:[[UIView alloc] init]];\n\t\t[_%@ setBackgroundColor:[UIColor whiteColor]];\n\t}\n\treturn _%@;\n}\n", self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className];
}

#pragma mark - kUIButton
- (NSString *)genderUIButtonGetter {
    return [NSString stringWithFormat:@"- (UIButton *)%@ {\n\tif (!_%@) {\n\t\t_%@ = [[UIButton alloc] init];\n\t\t[_%@ setTitle:<#申请大神#> forState:UIControlStateNormal];\n\t\t[_%@ setTitleColor:[ThemeManager colorWithHexString:@\"#2F2F2F\"] forState:UIControlStateNormal];\n\t\t[_%@ setImage:[UIImage imageNamed:@\"icon_home_apply_god\"] forState:UIControlStateNormal];\n\t\t_%@.titleLabel.font = [UIFont systemFontOfSize:15.0f];\n\t\t_%@.backgroundColor = [UIColor whiteColor];\n\t\t_%@.layer.masksToBounds = YES;\n\t\t_%@.layer.cornerRadius = 4.0;\n\t}\n\treturn _%@;\n}\n\n", self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className];
}

#pragma mark - kUILabel
- (NSString *)genderUILabelGetter {
    return [NSString stringWithFormat:
            @"- (UILabel *)%@ {\n\t"
            @"if (!_%@) {\n\t\t"
            @"_%@ = [[UILabel alloc] initWithFrame:CGRectZero];\n\t\t"
            @"_%@.backgroundColor = [UIColor colorWithHexString:@\"#2F2F2F\"];\n\t\t"
            @"_%@.textAlignment = NSTextAlignmentCenter;\n\t\t"
            @"_%@.textColor = [UIColor whiteColor];\n\t\t"
            @"_%@.font = [UIFont systemFontOfSize:12.0f];\n\t"
            @"}\n\t"
            @"return _%@;\n"
            @"}\n\n", self.className, self.className, self.className, self.className, self.className, self.className, self.className, self.className];
}

#pragma mark - kUIImageView
- (NSString *)genderUIImageViewGetter {
    return [NSString stringWithFormat:
            @"- (UIImageView *)%@ {\n\t"
            @"if (!_%@) {\n\t\t"
            @"_%@ = [[UIImageView alloc] initWithFrame:CGRectZero];\n\t\t"
            @"_%@.image = [UIImage imageNamed:<#(nonnull NSString *)#>];\n\t\t"
            @"}\n\t"
            @"return _%@;\n"
            @"}\n\n", self.className, self.className, self.className, self.className, self.className];
}

#pragma mark - kYYAnimatedImageView
- (NSString *)genderYYAnimatedImageViewGetter {
    return [NSString stringWithFormat:
            @"- (YYAnimatedImageView *)%@ {\n\t"
            @"if (!_%@) {\n\t\t"
            @"_%@ = [[YYAnimatedImageView alloc] initWithFrame:CGRectZero];\n\t\t"
            @"_%@.image = [UIImage imageNamed:<#(nonnull NSString *)#>];\n\t\t"
            @"}\n\t"
            @"return _%@;\n"
            @"}\n\n", self.className, self.className, self.className, self.className, self.className];
}

#pragma mark - kPublic class
- (NSString *)genderPublicClassGetter:(NSString *)className {
    return [NSString stringWithFormat:
            @"- (%@ *)%@ {\n\t"
            @"if (!_%@) {\n\t\t"
            @"_%@ = [[%@ alloc] init];\n\t\t"
            @"}\n\t"
            @"return _%@;\n"
            @"}\n\n", className, self.className, self.className, self.className, className, self.className];
}

- (NSString *)objectNameWithClassName:(NSString *)className {
    NSRange range = [className rangeOfString:@"*"];
    if (range.location == NSNotFound) {
        return @"ZHZ";
    }
    NSRange range2 = [className rangeOfString:@";"];
    if (range2.location == NSNotFound) {
        return @"ZHZ";
    }
    NSString *string = [className substringWithRange:NSMakeRange(range.location+1, range2.location-range.location-1)];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)classNameWithLineCode:(NSString *)lineCode {
    NSRange range = [lineCode rangeOfString:@")"];
    if (range.location == NSNotFound) {
        return @"ZHZ";
    }
    NSRange range2 = [lineCode rangeOfString:@"*"];
    if (range2.location == NSNotFound) {
        return @"ZHZ";
    }
    NSString *string = [lineCode substringWithRange:NSMakeRange(range.location+1, range2.location-range.location-1)];
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSInteger)lastEnd:(XCSourceEditorCommandInvocation *)invocation {
    __block NSInteger line = NSNotFound;
    [invocation.buffer.lines enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj containsString:@"end"]) {
            line = idx;
            *stop = YES;
        }
    }];
    return line;
}

@end
