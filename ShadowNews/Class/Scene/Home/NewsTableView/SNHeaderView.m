//
//  SNFirstNewsCell.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNHeaderView.h"
#import "SNLocalNewsModel.h"
#import "SNNomarlNewsModel.h"


#define HEADERWIDTH 320
#define HEADERHEIGHT 100

@implementation SNHeaderView
- (void)dealloc
{
    RELEASE_SAFELY(_firstNewsArray);
    RELEASE_SAFELY(_scrollView);
    RELEASE_SAFELY(_imageArray);
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview
{
    CGFloat width = self.frame.size.width;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HEADERWIDTH, HEADERHEIGHT)];
    _scrollView.backgroundColor = [UIColor cyanColor];
    _scrollView.contentSize = CGSizeMake(3 * HEADERWIDTH, HEADERHEIGHT);
    _scrollView.contentOffset = CGPointMake(HEADERWIDTH, 0);
    _scrollView.pagingEnabled = YES;
    // !!!:禁用回弹
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 3; i++) {
        UIScrollView * scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(HEADERWIDTH*i, 0, width, HEADERHEIGHT)];
        scroll.backgroundColor = [UIColor redColor];
        [_scrollView addSubview:scroll];
        scroll.showsVerticalScrollIndicator = NO;
        scroll.showsHorizontalScrollIndicator = NO;
        [scroll release];
    }
    [self addSubview:_scrollView];   
    self.imageArray = [NSMutableArray array];
}

- (void)setFirstNewsArray:(NSArray *)firstNewsArray
{
    if (_firstNewsArray != firstNewsArray) {
        [_firstNewsArray release];
        _firstNewsArray = [firstNewsArray retain];
    }
    for (int i = 0; i < self.firstNewsArray.count; i++) {
//       SNLocalNewsModel * news = [_firstNewsArray objectAtIndex:i];
        SNNomarlNewsModel * news = [_firstNewsArray objectAtIndex:i];
       // !!!:还要添加标题,后期优化
        UIImageView * newsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,HEADERWIDTH, HEADERHEIGHT)];
        newsImageView.userInteractionEnabled = YES;
        
        [newsImageView setImageWithURL:[NSURL URLWithString:news.imgSrc]];
        [_imageArray addObject:newsImageView];
        [newsImageView release];
    }
    if ([_imageArray count] == 1) {
        _scrollView.scrollEnabled = NO;
    }
    UIScrollView * secondScroll = [[_scrollView subviews] objectAtIndex:1];
    [secondScroll addSubview:[_imageArray objectAtIndex:0]];
    
  //  NSLog(@"_scrollView.subviews = %@",_scrollView.subviews);
}


@end
