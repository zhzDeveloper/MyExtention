//
//  CheckImportHeaderCommand.m
//  MyExtention
//
//  Created by zhz on 2017/7/2.
//  Copyright © 2017年 zhz. All rights reserved.
//

#import "CheckImportHeaderCommand.h"

@implementation CheckImportHeaderCommand
- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler {

    // 删除重复的
    NSMutableArray *importList = [NSMutableArray array];
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int idx = 0; idx < invocation.buffer.lines.count; idx++) {
        NSString *lineCode = invocation.buffer.lines[idx];
        if (![lineCode containsString:@"#import"]) {
            continue;
        }
        __block BOOL hasImported = NO;        [importList enumerateObjectsUsingBlock:^(NSString *_Nonnull obj, NSUInteger i, BOOL * _Nonnull stop) {
            NSString *codeline = [[lineCode stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            if ([codeline isEqualToString:obj]) {
                [indexSet addIndex:idx];
                hasImported = YES;
                *stop = YES;
            }
        }];
        if (hasImported) {
            continue;
        }
        [importList addObject:[[lineCode stringByReplacingOccurrencesOfString:@" " withString:@""] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
    }
    if (indexSet.count > 0) {
        [invocation.buffer.lines removeObjectsAtIndexes:indexSet];
    }
    
    // 删除没用的
    
    
    completionHandler(nil);
}

@end
