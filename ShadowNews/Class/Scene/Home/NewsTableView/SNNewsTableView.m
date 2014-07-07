//
//  SNNewsTableView.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-7.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsTableView.h"
#import "SNHeaderView.h"
#import "MJRefresh.h"

@interface SNNewsTableView ()




@end


@implementation SNNewsTableView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews
{

    self.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,SNNewsTableHeaderViewHeight)] autorelease];
    self.tableHeaderView.backgroundColor = [UIColor grayColor];
    self.headerView = [[[SNHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SNNewsTableHeaderViewHeight)] autorelease];
    [self.tableHeaderView addSubview:self.headerView];
    
    self.footerRefreshView = [MJRefreshFooterView footer];
    self.footerRefreshView.scrollView = self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
