//
//  SNNewsItemView.h
//  ShadowNews
//
//  Created by lanou3g on 14-6-29.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNNewsItemView;
/**
 *  用于约定页眉的行为和行为.
 */
@protocol SNNewsItemViewDelegate <NSObject>
@optional
/**
 *  设置某位置页眉单元格的宽度.
 *
 *  @param newsItemView   新闻视图页眉对象.
 *  @param index            位置.
 *
 *  @return 此位置页眉单元格的宽度.
 */
- (CGFloat) newsItemView: (SNNewsItemView *) newsItemView
       widthForCellAtIndex: (NSUInteger) index;

/**
 *  点击页眉某个按钮的响应事件.
 *
 *  @param newsItemView 新闻视图页眉对象.
 *  @param index          位置.
 */
- (void) newsItemView: (SNNewsItemView *) newsItemView
didClickSegmentActionAtIndex: (NSUInteger) index;

@end

/**
 * 用于约定为页眉提供数据.
 */
@protocol SNNewsItemViewDataSource <NSObject>

@required

/**
 *  获取新闻菜单.
 *
 *  @param newsItemView 新闻视图页眉对象.
 *
 *  @return 新闻菜单对象.
 */

- (NSArray *) menuInNewsItemView: (SNNewsItemView *) newsItemView;

@end

@interface SNNewsItemView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)id<SNNewsItemViewDelegate> delegate;//!< 布局代理.
@property(nonatomic,assign)id<SNNewsItemViewDataSource> dataSource;//!< 数据源代理.
@property (assign, nonatomic) NSUInteger selectedIndex; //!< 被选中的位置.


@end
