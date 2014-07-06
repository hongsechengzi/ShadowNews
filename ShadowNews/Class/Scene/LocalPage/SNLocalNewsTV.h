//
//  SNLocalNewsTV.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNLocalNewsTV : NSObject<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)NSArray * newsArray;//!<要展示的新闻数组

@end
