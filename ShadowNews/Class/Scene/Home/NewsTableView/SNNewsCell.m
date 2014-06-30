//
//  SNNewsCell.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsCell.h"
#import "UIImageView+WebCache.h"
#import "SNLocalNewsModel.h"


@interface SNNewsCell ()

@property(nonatomic,retain)UIImageView * newsImage;
@property(nonatomic,retain)UILabel * titleLabel;
@property(nonatomic,retain)UILabel * detailLabel;

@end

@implementation SNNewsCell
- (void)dealloc
{
    RELEASE_SAFELY(_news);
    RELEASE_SAFELY(_titleLabel);
    RELEASE_SAFELY(_detailLabel);
    RELEASE_SAFELY(_newsImage);
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setupSubview];
    }
    return self;
}
- (void)setupSubview
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    self.newsImage = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width/4, height)] autorelease];
    self.newsImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:_newsImage];
    
    self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(width/4 , 0, width-width/4, height/3)] autorelease];
    self.titleLabel.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[[UILabel alloc] initWithFrame:CGRectMake(width/4 , height/3, width-width/4, 2 *height/3)] autorelease];
    self.detailLabel.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.detailLabel];
}

- (void)setNews:(SNLocalNewsModel *)news
{
    if (_news != news) {
        [_news release];
        _news = [news retain];
    }
    self.titleLabel.text = news.title;
    self.detailLabel.text = news.title;
    NSURL * url = [NSURL URLWithString:news.imgSrc];
    
    [self.newsImage setImageWithURL:url];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
