//
//  SNHeaderNewsTV.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNHeaderNewsTV.h"
#import "SNHeaderNewsModel.h"
#import "SNNormalNewsCell.h"
#import "SNShowImageCell.h"

@implementation SNHeaderNewsTV
- (void)dealloc
{
    self.newsArray = nil;
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.newsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // SNLocalNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    SNHeaderNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    
    if (nil != news.imgExtraArray) {
        static NSString * imageIdentifier = @"imageCell";
        SNShowImageCell * cell =  [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
        if (!cell) {
            cell = [[SNShowImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:imageIdentifier];
        }
        cell.news = news;
        return cell;
    }
    static NSString * identifier = @"normalCell";
    SNNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[SNNormalNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.news = news;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNHeaderNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    if (nil != news.imgExtraArray) {
        return 100;
    }
    return 70;
}


@end
