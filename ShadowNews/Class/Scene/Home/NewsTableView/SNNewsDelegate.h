//
//  SNNewsDelegate.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-8.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNNewsItemView;
@class SNMainMenu;
/**
 *  新闻代理类.
 */
@interface SNNewsDelegate : UIView<UITableViewDelegate,UITableViewDataSource>
/**
 *  便利构造器.
 *
 *  @param cell   新闻视图单元格对象.
 *  @param model  新闻数据模型.
 *
 *  @return 实例对象.
 */
//!!!: 不需要传Model进来.
+ (instancetype) delegateWithCell: (SNNewsItemView *) cell
                            mainMenu: (SNMainMenu *) mainMenu;

/**
 *  便利初始化.
 *
 *  @param cell  新闻视图单元格对象.
 *  @param model  新闻数据模型.
 *
 *  @return 实例对象.
 */
- (instancetype) initWithCell: (SNNewsItemView *) cell
                     mainMenu: (SNMainMenu *) mainMenu;
@end
