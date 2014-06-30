//
//  SNNewsCell.h
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNLocalNewsModel;
@interface SNNewsCell : UITableViewCell
@property(nonatomic,readonly,retain)UIImageView * newsImage;
@property(nonatomic,readonly,retain)UILabel * titleLabel;
@property(nonatomic,readonly,retain)UILabel * detailLabel;
@property(nonatomic,retain)SNLocalNewsModel * news;

@end
