//
//  SNNomarlNewsPageModel.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNomarlNewsPageModel.h"
#import "SNNomarlNewsModel.h"
#import "SNMainMenu.h"

@implementation SNNomarlNewsPageModel

+ (void) nomarlMainMenu:(SNMainMenu *)newsItem range:(NSRange)range success:(SNNormalPageModelSuccessBlock)success fail:(SNNormalPageModelFailBlock)fail
{
    NSString * urlKey = newsItem.urlKeyStr;
    NSString * urlStr = [NSString stringWithFormat: @"http://c.3g.163.com/nc/article/list/%@/%lu-%lu.html",urlKey,range.location, range.length];
   NSLog(@"urlStr = %@",urlStr);
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
    
    [manager GET: urlStr parameters: nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray * newsOriginalArray = [responseObject objectForKey: urlKey];
        NSMutableArray * normalNewsArray = [NSMutableArray arrayWithCapacity: 42];
        
        [newsOriginalArray enumerateObjectsUsingBlock:^(NSDictionary * newsOriginal, NSUInteger idx, BOOL *stop) {
            NSString * imgSrc = [newsOriginal objectForKey: @"imgsrc"];
            NSString * title = [newsOriginal objectForKey: @"title"];
            NSUInteger replyCount = [(NSNumber *)[newsOriginal objectForKey: @"replyCount"] unsignedIntegerValue];
            NSString * docId = [newsOriginal objectForKey: @"docid"];
            NSString * digest = [newsOriginal objectForKey:@"digest"];
            NSString * tag = [newsOriginal objectForKey:@"TAG"];
            
            NSArray * imgExtraArray = [newsOriginal objectForKey:@"imgextra"];
            [normalNewsArray addObject:[SNNomarlNewsModel normarlNewsWithImgSrc:imgSrc title:title replyCount:replyCount docId:docId digest:digest tag:tag imgExtraArray:imgExtraArray]];
        }];
        success(normalNewsArray);
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        fail(error);
    }];
}


@end
