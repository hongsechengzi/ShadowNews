//
//  SNRefreshBaseView.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-3.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNRefreshBaseView.h"
#import "SNRefreshConst.h"

@interface SNRefreshBaseView ()
@property(nonatomic,assign)BOOL hasInitInset;
@end

@implementation SNRefreshBaseView

- (void)dealloc
{

    [super dealloc];
}

#pragma mark---创建一个UILable
- (UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel * label = [[UILabel alloc] init];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont systemFontOfSize:size];
    label.backgroundColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    return [label autorelease];

}
- (instancetype)initWithScrollView:(UIScrollView *)scrollView
{
    if (self = [super init]) {
        self.scrollVeiw = scrollView;
    }
    return self;
}
- (void)layoutSubviews
{
    NSLog(@"%s",__FUNCTION__);
    [super layoutSubviews];
    if (!self.hasInitInset) {
        self.scrollVeiwInitInset = self.scrollVeiw.contentInset;
        
        NSLog(@"self.scrollVeiw.contentInset == %@",NSStringFromUIEdgeInsets(self.scrollVeiw.contentInset));
        
        [self observeValueForKeyPath:SNRefreshContentSize ofObject:nil change:nil context:nil];
        self.hasInitInset = YES;
        if (_state == SNRefreshStateWillRefreshing) {
            [self setState:SNRefreshStateWillRefreshing];
        }
    }

}
- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"%s",__FUNCTION__);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //自己属性
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.backgroundColor = [UIColor blueColor];
        //时间标签
        self.lastUpdateTimeLabel = [self labelWithFontSize:12];
        [self addSubview:self.lastUpdateTimeLabel];
       
        //状态标签
        self.statusLabel = [self labelWithFontSize:13];
        [self addSubview:self.statusLabel];
     
        //箭头图片
         self.arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"102-walk"]];
         self.arrowImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
        //self.arrowImage = arrowImage;
        [self addSubview:self.arrowImage];
        
        //指示器
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.bounds = self.arrowImage.bounds;
        self.activityView.autoresizingMask = self.arrowImage.autoresizingMask;
        [self addSubview:self.activityView];
        //设置默认状态
        [self setState:SNRefreshStateNormal];
    }
    return self;
}

#pragma mark 设置frame
- (void)setFrame:(CGRect)frame
{
    NSLog(@"%s",__FUNCTION__);
    frame.size.height = SNRefreshViewHeight;
    [super setFrame:frame];
    CGFloat width = frame.size.width;
    CGFloat height = frame.size.height;
    if (width == 0 ||self.arrowImage.center.y == height* 0.5) {
        return;
    }
    CGFloat statusX = 0;
    CGFloat statusY = 5;
    CGFloat statusHeight = 20;
    CGFloat statusWidth = width;
    //状态标签
    self.statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    //时间标签
    CGFloat lastUpdateY = statusY + statusHeight + 5;
    self.lastUpdateTimeLabel.frame = CGRectMake(statusX, lastUpdateY, statusWidth, statusHeight);
  //  self.lastUpdateTimeLabel.backgroundColor = [UIColor greenColor];
    //箭头
    CGFloat arrowX = width* 0.5 -100;
    self.arrowImage.center = CGPointMake(arrowX, height* 0.5);
    //指示器
    self.activityView.center = self.arrowImage.center;
}
- (void)setBounds:(CGRect)bounds
{
    NSLog(@"%s",__FUNCTION__);
    bounds.size.height = SNRefreshViewHeight;
    [super setBounds:bounds];
}
#pragma pargma mark UIScrollView相关
#pragma mark  设置UIScrollView
- (void)setScrollVeiw:(UIScrollView *)scrollVeiw
{
    NSLog(@"%s",__FUNCTION__);
    //移除之前的监听器
    [_scrollVeiw removeObserver:self forKeyPath:SNRefreshContentOffset context:nil];
    //监听contentOffset
    [_scrollVeiw addObserver:self forKeyPath:SNRefreshContentOffset options:NSKeyValueObservingOptionNew context:nil];
    //设置scrollView
    _scrollVeiw = scrollVeiw;
    [_scrollVeiw addSubview:self];

}
#pragma mark 监听UIScrollview的contentOffset属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%s",__FUNCTION__);
    if (![SNRefreshContentOffset isEqualToString:keyPath])
        return;
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden || self.state == SNRefreshStateRefreshing)
        return;
    //scrollView所滚动的Y值 * 控件的类型(头部控件是-1,尾部控件是1)
    //???:refresh问题
    CGFloat offsetY = self.scrollVeiw.contentOffset.y * [self viewType];
    CGFloat validY = [self validY];
    if (offsetY <= validY) {
        return;
    }
    if (self.scrollVeiw.isDragging) {
        CGFloat validOffsetY = validY + SNRefreshViewHeight;
        if (self.state == SNRefreshStatePulling && offsetY <= validOffsetY) {
            //转为普通状态
            [self setState:SNRefreshStateNormal];
            //通知代理
//            if ([self.delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
//                [self.delegate refreshView:self stateChange:SNRefreshStateNormal];
//            }
            //回调
            if (_refreshStateChangeBlock) {
                _refreshStateChangeBlock(self,SNRefreshStateNormal);
            }
            }else if (self.state == SNRefreshStateNormal && offsetY >validOffsetY){
            //转为即将刷新状态
                [self setState:SNRefreshStatePulling];
                //通知代理
                if ([self.delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
                    [self.delegate refreshView:self stateChange:SNRefreshStatePulling];
                }
                //回调
                if (_refreshStateChangeBlock) {
                    _refreshStateChangeBlock(self,SNRefreshStatePulling);
                }
            }
        }else{
            //即将刷新&& 手松开
            if (self.state == SNRefreshStatePulling) {
                //开始刷新
                [self setState:SNRefreshStateRefreshing];
                //通知代理
                if ([self.delegate respondsToSelector:@selector(refreshView:stateChange:)]) {
                    [self.delegate refreshView:self stateChange:SNRefreshStateRefreshing];
                }
                //回调
                if (_refreshStateChangeBlock) {
                     _refreshStateChangeBlock(self, SNRefreshStateRefreshing);
                }
                
            }
        }
}
#pragma mark  设置状态
- (void)setState:(SNRefreshState)state
{
NSLog(@"%s",__FUNCTION__);
    if (_state != SNRefreshStateRefreshing) {
        //储存当前的contentInset
        self.scrollVeiwInitInset = self.scrollVeiw.contentInset;
    }
    //一样就直接返回
    if (_state == state) return;
    switch (state) {
        case SNRefreshStateNormal:
            //普通状态
            //显示箭头
            self.arrowImage.hidden = NO;
            //停止装圈圈
            [self.activityView stopAnimating];
            //说明是刚刚刷新完毕 回到 普通状态的
            if (SNRefreshStateRefreshing == self.state) {
                //通知代理
                if ([self.delegate respondsToSelector:@selector(refreshViewEndRefreshing:)]) {
                    [self.delegate refreshViewEndRefreshing:self];
                }
                //回调
                if (_endRefreshingBlock) {
                    _endRefreshingBlock(self);
                }
            }
            break;
       case SNRefreshStatePulling:
            break;
       case SNRefreshStateRefreshing:
            //开始转圈圈
            [self.activityView startAnimating];
            //隐藏箭头
            self.arrowImage.hidden = YES;
            self.arrowImage.transform = CGAffineTransformIdentity;
            //通知代理
            if ([self.delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]) {
                [self.delegate refreshViewBeginRefreshing:self];
            }
            //回调
            if (_beginRefreshingBlock) {
                _beginRefreshingBlock(self);
            }
            break;
        default:
            break;
    }
    //存储状态
    _state = state;
}
#pragma mark - 状态相关
#pragma mark 是否正在刷新
- (BOOL)isRefreshing
{
    NSLog(@"%s",__FUNCTION__);
    return SNRefreshStateRefreshing == self.state;
}
#pragma mark  开始刷新
- (void)begingRefreshing
{
    NSLog(@"%s",__FUNCTION__);
    if (self.window) {
        [self setState:SNRefreshStateRefreshing];
    }else{
        _state = SNRefreshStateWillRefreshing;
    
    }
}
#pragma mark  结束刷新
- (void)endRefreshing
{
    NSLog(@"%s",__FUNCTION__);
    double delayInSeconds = self.viewType == SNRefreshViewTypeFooter ? 0.3:0.0 ;
  //  dispatch_time_t popTime  = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    //延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setState:SNRefreshStateNormal];
    });

}
#pragma mark-----随便实现
- (CGFloat)validY{return 0;}
- (SNRefreshViewType)viewType{return SNRefreshViewTypeHeader;}
- (void)free
{
    NSLog(@"%s",__FUNCTION__);
    [self.scrollVeiw removeObserver:self forKeyPath:SNRefreshContentOffset];
}
- (void)removeFromSuperview
{
    NSLog(@"%s",__FUNCTION__);
    [self free];
    self.scrollVeiw = nil;
    [super removeFromSuperview];
}
- (void)endRefreshingWithoutIdle
{
    [self endRefreshing];
}



- (int)totalDataCountInScrollView
{
    int totalCount = 0;
    if ([self.scrollVeiw isKindOfClass:[UITableView class]]) {
        UITableView * tableView = (UITableView *)self.scrollVeiw;
        for (int section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }else if ([self.scrollVeiw isKindOfClass:[UICollectionView class]]){
        UICollectionView * collectionView = (UICollectionView *)self.scrollVeiw;
        for (int section = 0; section < collectionView.numberOfSections; section ++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
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
