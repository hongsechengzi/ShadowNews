//
//  SNRefreshBaseView.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-3.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  控件的刷新状态,枚举
 */
typedef enum {
    SNRefreshStatePulling = 1,//松开就可以进行刷新的状态
    SNRefreshStateNormal = 2,//普通状态
    SNRefreshStateRefreshing = 3,//正在刷新中的状态
    SNRefreshStateWillRefreshing = 4
} SNRefreshState;

/**
 * 控件类型
 */
typedef enum{
    SNRefreshViewTypeHeader = -1,//头部控件
    SNRefreshViewTypeFooter = 1//尾部控件
} SNRefreshViewType ;

@class SNRefreshBaseView;
/**
 *  回调的Block定义,开始进入刷新状态就会调用
 */
typedef void(^BeginRefreshingBlock)(SNRefreshBaseView * refreshView);

/**
 *  刷新完毕就会调用
 */
typedef void(^EndRefreshingBlock)(SNRefreshBaseView * refreshView);

/**
 *  刷新状态变更就会调用
 */
typedef void(^RefreshStateChangeBlock)(SNRefreshBaseView * refreshView,SNRefreshState  state);

/**
 *  代理协议
 */
@protocol SNRefreshBaseViewDelegate <NSObject>

@optional
//开始进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(SNRefreshBaseView *)refreshView;
// 刷新完毕就会调用
- (void)refreshViewEndRefreshing:(SNRefreshBaseView *)refreshView;
// 刷新状态变更就会调用
- (void)refreshView:(SNRefreshBaseView *)refreshView stateChange:(SNRefreshState)state;
@end


@interface SNRefreshBaseView : UIView
@property(nonatomic,assign)UIEdgeInsets scrollVeiwInitInset;

// 设置要显示的父控件
@property(nonatomic,retain)UIScrollView * scrollVeiw;
@property(nonatomic,retain)UILabel * lastUpdateTimeLabel;
@property(nonatomic,retain)UILabel * statusLabel;
@property(nonatomic,retain)UIImageView * arrowImage;
@property(nonatomic,retain)UIActivityIndicatorView * activityView;
@property(nonatomic,assign)SNRefreshState state;



@property(nonatomic,copy)BeginRefreshingBlock beginRefreshingBlock;
@property(nonatomic,copy)EndRefreshingBlock endRefreshingBlock;
@property(nonatomic,copy)RefreshStateChangeBlock refreshStateChangeBlock;
@property(nonatomic,assign)id<SNRefreshBaseViewDelegate> delegate;

/**
 *  是否正在刷新
 */
@property(nonatomic,readonly,getter = isRefreshing)BOOL refreshing;


//构造方法
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

/**
 *  开始刷新
 */
- (void)begingRefreshing;
/**
 *  结束刷新
 */
- (void)endRefreshing;

/**
 *  结束使用,释放资源
 */
- (void)free;
//- (void)setState:(SNRefreshState)state;

- (int)totalDataCountInScrollView;
//交给子类去实现
//合理的Y值
- (CGFloat)validY;
//view的类型
- (SNRefreshViewType)viewType;


@end
