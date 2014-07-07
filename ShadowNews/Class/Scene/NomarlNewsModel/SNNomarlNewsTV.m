//
//  SNNomarlNewsTV.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNomarlNewsTV.h"
#import "SNNomarlNewsModel.h"
#import "SNShowImageCell.h"
#import "SNNormalNewsCell.h"

@implementation SNNomarlNewsTV

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
    NSLog(@"normal :[self.newsArray count] = %ld",[self.newsArray count]);
    
    return [self.newsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SNNomarlNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    
    if (nil != news.imgExtraArray) {
        static NSString * imageIdentifier = @"imageCell";
        SNShowImageCell * cell =  [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
        if (!cell) {
            cell = [[[SNShowImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:imageIdentifier] autorelease];
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
    SNNomarlNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    if (nil != news.imgExtraArray) {
        return 100;
    }
    return 70;
}

@end
