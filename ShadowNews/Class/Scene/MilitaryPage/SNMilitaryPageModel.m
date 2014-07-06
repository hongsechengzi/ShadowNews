//
//  SNMilitaryPageModel.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNMilitaryPageModel.h"
#import "SNSimpleNewsModel.h"

@implementation SNMilitaryPageModel

+ (void)range:(NSRange)range success:(SNMilitaryPageModelSuccessBlock)success fail:(SNMilitaryPageModelFailBlock)fail

{
    NSString * urlStr = [NSString stringWithFormat: @"http://c.3g.163.com/nc/article/list/T1348648141035/%lu-%lu.html", range.location, range.length];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    [manager GET: urlStr parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * newsOriginalArray = [responseObject objectForKey: @"T1348648141035"];
        NSMutableArray * militaryNewsArray = [NSMutableArray arrayWithCapacity: 42];
        [newsOriginalArray enumerateObjectsUsingBlock:^(NSDictionary * newsOriginal, NSUInteger idx, BOOL *stop) {
            NSString * imgSrc = [newsOriginal objectForKey: @"imgsrc"];
            NSString * title = [newsOriginal objectForKey: @"title"];
            NSString * publishTime = [newsOriginal objectForKey: @"lmodify"];
            NSUInteger replyCount = [(NSNumber *)[newsOriginal objectForKey: @"replyCount"] unsignedIntegerValue];
            NSString * docId = [newsOriginal objectForKey: @"docid"];
            [militaryNewsArray addObject:[SNSimpleNewsModel simpleNewsWithImgSrc:imgSrc title:title publishTime:publishTime replyCount:replyCount docId:docId]];
        }];
        success(militaryNewsArray);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        fail(error);
    }];
}

@end
