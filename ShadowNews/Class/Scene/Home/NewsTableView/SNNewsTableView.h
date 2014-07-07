//
//  SNNewsTableView.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SNNewsTableViewDelegate <NSObject>


@end

@class SNHeaderView;
@class MJRefreshHeaderView;
@class MJRefreshFooterView;
@interface SNNewsTableView : UITableView

@property(nonatomic,retain)SNHeaderView * headerView;//!<头条新闻视图
@property(nonatomic,assign)id<SNNewsTableViewDelegate> refreshData;

@property(nonatomic,retain)MJRefreshFooterView * footerRefreshView;
@property(nonatomic,retain)MJRefreshHeaderView * headerRefreshView;
@end
