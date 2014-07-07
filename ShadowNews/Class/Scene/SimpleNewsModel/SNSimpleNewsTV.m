//
//  SNMilitaryNewsTV.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNSimpleNewsTV.h"
#import "SNSimpleNewsModel.h"
#import "SNSimplePageModel.h"

#import "SNHeaderView.h"
#import "MJRefresh.h"

#import "SNNewsTableView.h"

#import "SNTimeCell.h"
#import "SNSimpleNewsCell.h"
#import "SNMainMenu.h"



@implementation SNSimpleNewsTV

- (void)dealloc
{
    self.newsArray = nil;
    [super dealloc];
}

- (instancetype)initWithTableView:(SNNewsTableView *)tableView
{
    self = [super init];
    if (self) {
        self.tableView = tableView;
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    return self;
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
            cell = [[[SNSimpleNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:imageIdentifier] autorelease];
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

#pragma mark -------加载数据

- (void)handlePageDataWithMainMenu:(SNMainMenu *)mianMenu
{
    [SNSimplePageModel simpleMainMenu:mianMenu rageRange:NSMakeRange(0, 20) success:^(NSArray *simpleNewsArray) {
     self.newsArray = simpleNewsArray;
     self.tableView.headerView.firstNewsArray = simpleNewsArray;
         NSLog(@"=========");
    [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    self.tableView.footerRefreshView.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
        NSInteger  startRecord = self.newsArray.count;
        
        [SNSimplePageModel simpleMainMenu:mianMenu rageRange:NSMakeRange(startRecord, 20) success:^(NSArray *simpleNewsArray) {
            NSMutableArray * arr = [NSMutableArray arrayWithArray:self.newsArray];
            if ([[arr lastObject] isEqual:[simpleNewsArray firstObject]]) {
                [arr removeObject:arr.lastObject];
            }
            [arr addObjectsFromArray:simpleNewsArray];
            self.newsArray = (NSMutableArray *)arr;
            self.tableView.headerView.firstNewsArray = self.newsArray;
            [self.tableView.footerRefreshView endRefreshing];
          [self.tableView reloadData];
        } fail:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    };
}



@end
