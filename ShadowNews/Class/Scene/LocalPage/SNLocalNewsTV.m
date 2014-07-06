//
//  SNLocalNewsTV.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNLocalNewsTV.h"
#import "SNLocalNewsModel.h"
#import "SNTimeCell.h"

@implementation SNLocalNewsTV
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
    
    SNSimpleNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
    
    static NSString * identifier = @"timeCell";
    SNTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[SNTimeCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    cell.news = news;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 70;
}
@end
