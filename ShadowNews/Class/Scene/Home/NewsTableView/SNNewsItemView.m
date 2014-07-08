//
//  SNNewsItemView.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-29.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsItemView.h"

@interface SNNewsItemView ()

@property (retain, nonatomic) UIScrollView * SNNHScrollView; //!< 底部滚动视图.
@property (retain, nonatomic) UISegmentedControl * SNNHSegmentedControl; //!< 用于显示菜单.

@property(retain,nonatomic) NSArray * menuArray;

@end

@implementation SNNewsItemView
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    
    self.SNNHScrollView = nil;
    self.SNNHSegmentedControl = nil;
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [self SNNHSetupSubviews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /* 支持自定义页眉单元格宽度 */
    for (NSUInteger index = 0; index < self.SNNHSegmentedControl.numberOfSegments; index++) {
        [self.SNNHSegmentedControl setWidth:[self SNNHWidthOfCellAtIndex: index] forSegmentAtIndex: index];
    }
}

// ???:被选中的键,应该自动居中.
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    self.SNNHSegmentedControl.selectedSegmentIndex = selectedIndex;
    
    // ???:应该可以删掉.
    //    if ([self.delegate respondsToSelector:@selector(newsHeaderView:didClickSegmentActionAtIndex:)]) {
    //        [self.delegate newsHeaderView:self didClickSegmentActionAtIndex:selectedIndex];
    //    }
}

#pragma mark - 私有方法.
/**
 * 初始化子视图.
 */
- (void) SNNHSetupSubviews
{
    /* 创建视图. */
    UIScrollView * scrollView = [[UIScrollView alloc] init];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;
    
    self.SNNHScrollView = scrollView;
    SNRelease(scrollView);
    [self addSubview: self.SNNHScrollView];
    
    
    // ???:如何去调 segmentedControl的边框,好难看! UISegmentedControlStyle 可能和这个有关.
    UISegmentedControl * segmentedControl = [[UISegmentedControl alloc] initWithItems:self.menuArray];
    segmentedControl.translatesAutoresizingMaskIntoConstraints = NO;
    [segmentedControl addTarget:self action:@selector(SNNHDidClickSegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    
    self.SNNHSegmentedControl = segmentedControl;
    SNRelease(segmentedControl);
    [self.SNNHScrollView addSubview: self.SNNHSegmentedControl];
    
    /*设置视图约束*/
    NSMutableArray * constraints = [NSMutableArray arrayWithCapacity: 42];
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"|[scrollView]|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(scrollView)]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[scrollView]|" options:0 metrics: nil views: NSDictionaryOfVariableBindings(scrollView)]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"|[segmentedControl]|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(segmentedControl)]];
    
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat: @"V:|[segmentedControl]|" options:0 metrics:nil views: NSDictionaryOfVariableBindings(segmentedControl)]];
    
    [self addConstraints: constraints];
}

- (void)SNNHDidClickSegmentedControlAction:(UISegmentedControl *) segmentedControl
{
   // [self.delegate newsHeaderView:self didClickSegmentActionAtIndex: segmentedControl.selectedSegmentIndex];
    if ([self.delegate respondsToSelector:@selector(newsItemView:didClickSegmentActionAtIndex:)]) {
        [self.delegate newsItemView:self didClickSegmentActionAtIndex:segmentedControl.selectedSegmentIndex];
    }
    
}

/**
 *  单个单元格宽度.默认为屏幕宽度的1/5.可通过代理设置.
 *
 *  @return 单个单元格宽度.
 */
- (CGFloat) SNNHWidthOfCellAtIndex: (NSUInteger) index
{
    CGFloat width = self.frame.size.width / 5;
    if ([self.delegate respondsToSelector: @selector(newsItemView:widthForCellAtIndex:)]) {
        width = [self.delegate newsItemView:self widthForCellAtIndex:index];
    }
    
    return width;
}

//- (SNNewsMenu *)SNNHMenu
//{
//    if (nil == _SNNHMenu) {
//        self.SNNHMenu = [self.dataSource menuInNewsHeaderView: self];
//    }
//    
//    return _SNNHMenu;
//}
- (NSArray *)menuArray
{
    if (nil == _menuArray) {
        self.menuArray = [self.dataSource menuInNewsItemView:self];
    }
    return _menuArray;
}

#pragma mark - UIScrollViewDelegate协议方法.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
