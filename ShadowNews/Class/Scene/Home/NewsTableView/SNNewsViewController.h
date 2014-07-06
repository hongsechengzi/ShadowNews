//
//  SNNewsViewController.h
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNNewsItemView;
@interface SNNewsViewController : UIViewController<UIScrollViewDelegate>

@property(nonatomic,retain)NSArray * newsArray;//!<要展示的新闻数组

@property(nonatomic,retain)SNNewsItemView * newsItemScroll;//!< 选择新闻类型滚动条

@property(nonatomic,retain)NSDictionary * newsMenuDic;//!<新闻菜单的字典


@end
