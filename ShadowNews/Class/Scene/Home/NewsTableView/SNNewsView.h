//
//  SNNewsView.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-8.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNNewsItemView.h"

@class SNNewsView;
@class SNNewsTableView;

/**
 *  新闻视图布局协议.
 */
@protocol SNNewsViewDelegate <NSObject>
@optional
/**
 *  设置新闻视图页眉的高度.默认30.0.
 *
 *  @param newsView 轮转视图.
 *
 *  @return 返回页眉高度.
 */
- (CGFloat) heightForHeaderInNewsView: (SNNewsView *) newsView;

/**
 *  设置新闻视图所在页面导航栏的高度.默认为 64.0 .
 *
 *  注意: 导航栏并不是新闻视图内部封装的一部分.新闻视图本身将假设你会将其放到一个导航控制器(UINavigationController)
 *       进行管理.如果你使用了自定义的导航栏,且其高度不是64.0,请实现此代理方法,返回一个合适的高度.
 *
 *  @param newsView 新闻视图.
 *
 *  @return 返回页眉高度.
 */
- (CGFloat) heightForNavigationInNewsView: (SNNewsView *) newsView;

@optional

@end

/**
 *  新闻视图数据源协议.
 */
@protocol SNNewsViewDataSource <NSObject>

@required
/**
 *  设置用于某个新闻版块的视图.
 *
 *  注意: 出于用户体验的考虑,为预加载左右邻近页面的视图.为了避免页面频繁发起网络请求,您可以区别对待预加载和非预加载两种情况.如预加载时,只从本地数据库读取数据;只在真正加载页面时,才发起网络请求,获取最新数据.
 *
 *  @param newsView 新闻视图对象.
 *  @param title    新闻板块名称.
 *  @param preLoad  YES,是预加载;NO,不是预加载.
 *
 *  @return 用于某个位置的页面的视图.
 */
// !!!: tableView,强制要求返回不会nil,否则报错崩溃,有无必要效仿?
- (SNNewsTableView *)newsView:(SNNewsView *)newsView
                viewForTitle:(NSString *) title
                     preLoad:(BOOL) preLoad;

/**
 *  设置新闻视图菜单.
 *
 *  @param newsrView 新闻视图对象.
 *
 *  @return 一个新闻菜单对象.
 */
- (NSArray *) menuInNewsView: (SNNewsView *) newsView;

@optional
/**
 *  设置初始显示哪个位置的视图.
 *
 *  @param newsView 新闻视图对象.
 *
 *  @return 初始显示视图的位置.
 */
- (NSUInteger) indexForSetupCellInNewsView:(SNNewsView *) newsView;

@end

@interface SNNewsView : UIView<UIScrollViewDelegate,SNNewsItemViewDelegate,SNNewsItemViewDataSource>

@property(assign,nonatomic) id<SNNewsViewDelegate> delegate;//!<代理
@property(assign,nonatomic) id<SNNewsViewDataSource> dataSource;//!<数据源

@end
