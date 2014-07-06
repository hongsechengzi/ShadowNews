//
//  SNMilitaryNewsTV.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNMilitaryNewsTV.h"
#import "SNSimpleNewsModel.h"

#import "SNTimeCell.h"
#import "SNSimpleNewsCell.h"
#import "SNHomeConst.h"

@implementation SNMilitaryNewsTV

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
    
    if ([news.imgSrc isEqualToString:@""]) {
        NSString * imageIdentifier = SNSimpleNewsCellIdentifie;
        SNSimpleNewsCell * cell =  [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
        if (!cell) {
            cell = [[SNSimpleNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:imageIdentifier];
        }
        cell.news = news;
        return cell;
    }
    
     NSString * identifier = SNTimeNewsCellIdentifie;
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
