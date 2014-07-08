//
//  SNNewsDelegate.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-8.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsDelegate.h"
#import "SNNewsTableView.h"
#import "SNNewsItemView.h"
#import "SNMainMenu.h"


@interface SNNewsDelegate ()
@property(nonatomic,retain)SNNewsItemView * newsItem;
@property(nonatomic,retain)NSArray * newsArray;//!< 存储新闻的数组

@end

@implementation SNNewsDelegate



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype) delegateWithCell: (SNNewsItemView *) cell
                         mainMenu: (SNMainMenu *) mainMenu
{
    SNNewsDelegate * delegate = [[SNNewsDelegate alloc] initWithCell:cell mainMenu:mainMenu];
    return SNAutorelease(delegate);

}
- (instancetype) initWithCell: (SNNewsItemView *) cell
                     mainMenu: (SNMainMenu *) mainMenu
{

    if (self = [super init]) {
        self.newsItem = cell;
        
       
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
