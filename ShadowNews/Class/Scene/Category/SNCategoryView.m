//
//  SNCategoryView.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-30.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNCategoryView.h"

@implementation SNCategoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews
{
    self.backgroundColor = [UIColor cyanColor];
    
    NSArray * iconNameArr = @[@"01-refresh",@"02-redo",@"03-loopback",@"04-squiggle",@"05-shuffle",@"06-magnifying-glass"];
    NSArray * categoryArr = @[@"新闻",@"订阅",@"图片",@"视频",@"跟帖",@"电台"];
    
    for (int i = 0; i < 6; i++) {
        //图标
        UIImageView * iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 80 + 60*i, 30, 30)];
        UIImage * iconImage = [UIImage imageNamed:iconNameArr[i]];
        iconImageView.image = iconImage;
        [self addSubview:iconImageView];
        
        //按钮
        UIButton * categoryButton = [UIButton buttonWithType:UIButtonTypeSystem];
        categoryButton.frame = CGRectMake(80, 80 + 60*i, 60, 30);
        [categoryButton setTitle:categoryArr[i] forState:UIControlStateNormal];
        [categoryButton addTarget:self action:@selector(didClickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        categoryButton.titleLabel.font = [UIFont systemFontOfSize:24];
        [self addSubview:categoryButton];
    }

}
- (void)didClickButtonAction:(UIButton *)button
{
    NSLog(@"button.titleLabel.text %@",button.titleLabel.text);
    if ([self.delegate respondsToSelector:@selector(categoryViewDidClickButtonAction:)]) {
        [self.delegate categoryViewDidClickButtonAction:button];
    }

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
