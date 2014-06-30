//
//  SNNews.h
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNNews : NSObject

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * detail;
@property(nonatomic,copy)NSString * imageUrlString;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
