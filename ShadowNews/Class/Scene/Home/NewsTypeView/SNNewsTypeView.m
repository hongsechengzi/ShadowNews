//
//  SNNewsTypeView.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-29.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsTypeView.h"

@implementation SNNewsTypeView

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
    UIScrollView * scroll = [[[UIScrollView alloc] initWithFrame:self.frame] autorelease];
    scroll.backgroundColor = [UIColor redColor];
    [self addSubview:scroll];



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
