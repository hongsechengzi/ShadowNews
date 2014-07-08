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

#import "SNNewsTableView.h"
#import "SNMainMenu.h"
#import "SNNomarlNewsPageModel.h"
#import "SNHeaderView.h"
#import "MJRefresh.h"

@implementation SNNomarlNewsTV

- (void)dealloc
{
    self.tableView = nil;
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

- (void)setTableView:(SNNewsTableView *)tableView
{
    if (_tableView != tableView) {
        [_tableView release];
      _tableView = [tableView retain];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
- (void)handlePageDataWithMainMenu:(SNMainMenu *)mianMenu
{
    [SNNomarlNewsPageModel nomarlMainMenu:mianMenu range:NSMakeRange(0, 20) success:^(NSArray * nomarlNewsArray) {
        self.newsArray = nomarlNewsArray;
        self.tableView.headerView.firstNewsArray = self.newsArray;

        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    self.tableView.footerRefreshView.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
      NSInteger  startRecord = self.newsArray.count;
        
        [SNNomarlNewsPageModel nomarlMainMenu:mianMenu range:NSMakeRange(startRecord, 20) success:^(NSArray * nomarlNewsArray) {
            NSMutableArray * arr = [NSMutableArray arrayWithArray:self.newsArray];
            if ([[arr lastObject] isEqual:[nomarlNewsArray firstObject]]) {
                [arr removeObject:arr.lastObject];
            }
            [arr addObjectsFromArray:nomarlNewsArray];
            self.newsArray = (NSMutableArray *)arr;
            self.tableView.headerView.firstNewsArray = self.newsArray;
            [self.tableView.footerRefreshView endRefreshing];
            [self.tableView reloadData];
        } fail:^(NSError *error) {
            NSLog(@"error = %@",error);
        }];
    };
     self.tableView.headerRefreshView.beginRefreshingBlock = ^(MJRefreshBaseView * refreshView){
         [SNNomarlNewsPageModel nomarlMainMenu:mianMenu range:NSMakeRange(0, 20) success:^(NSArray * nomarlNewsArray) {
             self.newsArray = nomarlNewsArray;
             self.tableView.headerView.firstNewsArray = self.newsArray;
             [self.tableView.headerRefreshView endRefreshing];
             [self.tableView reloadData];
         } fail:^(NSError *error) {
             NSLog(@"error = %@",error);
         }];
 
         
         
     };
    

}

@end
