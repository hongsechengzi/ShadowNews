////  SNRefreshHeaderView.m
//  ShadowNews//
//  Created by lanou3g on 14-7-3.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNRefreshConst.h"
#import "SNRefreshHeaderView.h"

@interface SNRefreshHeaderView ()
//最后的更新时间
@property(nonatomic,retain)NSDate * lastUpdateTime;

@end
@implementation SNRefreshHeaderView

@synthesize state = _state;
+(instancetype)header
{
    return [[SNRefreshHeaderView alloc] init];
}
#pragma mark --UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollVeiw:(UIScrollView *)scrollVeiw
{
    NSLog(@"%s",__FUNCTION__);
    [super setScrollVeiw:scrollVeiw];
    //设置边框
    self.frame = CGRectMake(0, -SNRefreshViewHeight, scrollVeiw.frame.size.width,SNRefreshViewHeight);
    //加载时间
    self.lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:SNRefreshHeaderTimeKey];
}
#pragma mark - 状态相关
#pragma mark 设置最后的更新时间
- (void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    NSLog(@"%s",__FUNCTION__);
    _lastUpdateTime = lastUpdateTime;
    //归档
    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime forKey:SNRefreshHeaderTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //更新时间
    [self updateTimeLabel];

}
#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    NSLog(@"%s",__FUNCTION__);
    if (!_lastUpdateTime) {
        return;
    }
    //获得年月日
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;

    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];    NSDateComponents * cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    //格式化日期
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    if ([cmp1 day] == [cmp2 day]) {
        //今天
        formatter.dateFormat = @"今天 HH:mm";
    }else if ([cmp1 year] == [cmp2 year]){
    //今年
        formatter.dateFormat = @"MM-dd HH:mm";
        
    }else{
    formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString * time = [formatter stringFromDate:_lastUpdateTime];
    //显示日期
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后跟新:%@",time];
}
#pragma mark 设置状态
- (void)setState:(SNRefreshState)state
{
//一样的就直接返回
    if (_state == state) {
        return;
    }
    // 2.保存旧状态
    SNRefreshState oldState = _state;
    
    // 3.调用父类方法
    [super setState:state];
    //根据状态执行不同的操作
    switch (state) {
        case SNRefreshStatePulling:
            //松开可立即刷新
        {
        //设置文字
            self.statusLabel.text = SNRefreshHeaderReleaseToRefresh;
            [UIView animateWithDuration:SNRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = self.scrollVeiw.contentInset;
                inset.top = self.scrollVeiwInitInset.top;
                self.scrollVeiw.contentInset = inset;
            }];
        
            break;
        }
            // ???:break
          case SNRefreshStateNormal:
            //下拉可以刷新
        {
            self.statusLabel.text = SNRefreshHeaderPullToRefresh;
            //执行动画
            [UIView animateWithDuration:SNRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = self.scrollVeiw.contentInset;
                inset.top = self.scrollVeiwInitInset.top;
                self.scrollVeiw.contentInset = inset;
            }];
        //刷新完毕
            if (SNRefreshStateWillRefreshing == oldState) {
             //保存刷新时间
                self.lastUpdateTime = [NSDate date];
            }
            break;
        }
        case SNRefreshStateWillRefreshing:
        {
        //正在刷新中
            self.statusLabel.text = SNRefreshHeaderRefreshing;
            //执行动画
            [UIView animateWithDuration:SNRefreshAnimationDuration animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
              //增加65的滚动区域
                UIEdgeInsets inset = self.scrollVeiw.contentInset;
                inset.top = self.scrollVeiwInitInset.top + SNRefreshViewHeight;
                self.scrollVeiw.contentInset = inset;
                //设置滚动位置
                self.scrollVeiw.contentOffset = CGPointMake(0,- self.scrollVeiwInitInset.top - SNRefreshViewHeight);
            }];
            break;
        
        }
            
        default:
            break;
    }
}
#pragma mark - 在父类中用得上
//合理的Y值,(刚好看到下拉刷新控件时的contentOffset.y,取相反数)
- (CGFloat)validY
{
    return self.scrollVeiwInitInset.top;
}
//view的类型
- (SNRefreshViewType)viewType
{
    return SNRefreshViewTypeHeader;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
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
