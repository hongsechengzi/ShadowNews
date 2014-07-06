//
//  SNNewsViewController.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNewsViewController.h"

#import "SNHeaderView.h"
#import "SNNewsItemView.h"

#import "SNLocalPageModel.h"
#import "SNLocalNewsModel.h"
#import "SNHeaderPageModel.h"
#import "SNHeaderNewsModel.h"
#import "SNMainMenu.h"
#import "SNNomarlNewsModel.h"
#import "SNNomarlNewsPageModel.h"
#import "SNNomarlNewsTV.h"

#import "SNNormalNewsCell.h"
#import "SNShowImageCell.h"
#import "SNHomeConst.h"
#import "SNHeaderNewsTV.h"
#import "SNLocalNewsTV.h"
#import "SNMilitaryNewsTV.h"
#import "SNMilitaryPageModel.h"


#define MUNEHEIGHT 30
#define HEADERHEIGHT 100

@interface SNNewsViewController ()

@property(nonatomic,retain)SNHeaderView * headerView;//!<头条新闻视图
@property(nonatomic,assign)NSInteger currentIndex;//!<当前头条新闻图像下标
@property(nonatomic,retain)UITableView * tableView;//!表视图
@property(nonatomic,assign)NSInteger newsItemIndex;//!<新闻菜单下标
@property(nonatomic,retain)NSMutableArray * newsMenuArray;//!<菜单数组

@property(nonatomic,retain)SNHeaderNewsTV * headerNewsTV;//!<执行头条新闻tableview代理方法的对象
@property(nonatomic,retain)SNNomarlNewsTV * nomarlNewsTV;
@property(nonatomic,retain)SNLocalNewsTV * localNewsTV;//!<执行本地新闻tableview代理方法的对象
@property(nonatomic,retain)SNMilitaryNewsTV * militaryNewsTV;//军事



@end

@implementation SNNewsViewController
- (void)dealloc
{
    RELEASE_SAFELY(_headerView);
    RELEASE_SAFELY(_newsItemScroll);
    RELEASE_SAFELY(_newsArray);
    RELEASE_SAFELY(_tableView);
    self.headerNewsTV = nil;
    self.newsMenuArray = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    
    }
    return self;
}
- (void)viewDidLoad
{
    // NSLog(@"%@",self.tableView);
    [super viewDidLoad];
     self.title = @"ShadowNews";
    [self setupData];
    [self setupNormalSubviews];
    
    
    
    self.newsItemScroll = [[[SNNewsItemView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, MUNEHEIGHT)] autorelease];
    self.newsItemScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsItemScroll];
    self.newsItemScroll.showsVerticalScrollIndicator = NO;
    self.newsItemScroll.showsHorizontalScrollIndicator = NO;
    self.newsItemScroll.delegate = self;
    
    NSArray * newsArr = [self.newsMenuDic allKeys];
    self.newsMenuArray = [NSMutableArray arrayWithArray:newsArr];
    [self.newsMenuArray addObject:@"头条"];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:self.newsMenuArray];
    segment.frame = CGRectMake(0, 0,self.newsMenuArray.count * 60, MUNEHEIGHT);
    [self.newsItemScroll addSubview:segment];
    self.newsItemScroll.contentSize = CGSizeMake(self.newsMenuArray.count * 60, MUNEHEIGHT);
    [segment addTarget:self action:@selector(didClickSegmentControlAction:) forControlEvents:UIControlEventValueChanged];
}
- (void)setupNormalSubviews
{
    self.tableView = [[[UITableView alloc] initWithFrame:CGRectMake(5, MUNEHEIGHT, SCREENWIDTH-10, SCREENHEIGHT)] autorelease];
    //  self.tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
    self.headerNewsTV = [[[SNHeaderNewsTV alloc] init] autorelease];
    self.tableView.tableHeaderView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, HEADERHEIGHT)] autorelease];
    self.tableView.tableHeaderView.backgroundColor = [UIColor grayColor];
    self.headerView = [[[SNHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, HEADERHEIGHT)] autorelease];
    //  self.headerView.firstNewsArray = self.newsArray;
    self.headerView.scrollView.delegate = self;
    [self.tableView.tableHeaderView addSubview:self.headerView];
}

- (void)setupData
{
    [SNHeaderPageModel  header:@"头条" range:NSMakeRange(0, 20) success:^(NSArray *headerNewsArray) {
        self.newsArray = headerNewsArray;
        self.headerNewsTV.newsArray = self.newsArray;
        self.headerView.firstNewsArray = self.newsArray;
        self.tableView.delegate = self.headerNewsTV;
        self.tableView.dataSource = self.headerNewsTV;
       [self.tableView reloadData];

    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------选择新闻菜单的分段控件设置
- (void)didClickSegmentControlAction:(UISegmentedControl *)segmentControl
{
//    [self.newsItemArray objectAtIndex:segmentControl.selectedSegmentIndex];
    self.newsItemIndex = segmentControl.selectedSegmentIndex;
    NSString *  selectItem = [self.newsMenuArray objectAtIndex:segmentControl.selectedSegmentIndex];
    NSLog(@"selectitem = %@",selectItem);
    
    if ([selectItem isEqualToString:@"北京"]) {
        [self gotoLocalPage];
    }else{
        
    
     SNMainMenu * oneNewsMenu = [self.newsMenuDic objectForKey:selectItem];
        if ([oneNewsMenu.pageKey isEqualToString:@"normal"]) {
            
           [SNNomarlNewsPageModel mainMenu:oneNewsMenu range:NSMakeRange(0, 20) success:^(NSArray *headerNewsArray) {
               
               self.nomarlNewsTV = [[SNNomarlNewsTV alloc] init] ;
               self.newsArray = headerNewsArray;
               self.nomarlNewsTV.newsArray = self.newsArray;
               
               self.headerView.firstNewsArray = self.newsArray;
               self.tableView.delegate = self.nomarlNewsTV;
               self.tableView.dataSource = self.nomarlNewsTV;
               [self.tableView reloadData];
           } fail:^(NSError *error) {
               NSLog(@"error = %@",error);
           }];
            if ([oneNewsMenu.pageKey isEqualToString:@"simple"]) {
                
            }
            
        }
        
        
    
    
    }
    if ([selectItem isEqualToString:@"军事"]) {
        
        [self gotoMilitaryPage];
    }
   
}
- (void)gotoPolymerizationPage
{


    
    

}

- (void)gotoLocalPage
{
    [SNLocalPageModel local:@"北京" range:NSMakeRange(0, 20) success:^(NSArray *localNewsArray) {
        self.localNewsTV = [[SNLocalNewsTV alloc] init];
        self.newsArray = localNewsArray;
        self.headerView.firstNewsArray = self.newsArray;
        self.tableView.delegate = self.localNewsTV;
        self.tableView.dataSource = self.localNewsTV;
        self.localNewsTV.newsArray = self.newsArray;
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
- (void)gotoMilitaryPage
{
    [SNMilitaryPageModel range:NSMakeRange(0, 20) success:^(NSArray *militaryNewsArray) {
    self.militaryNewsTV = [[SNMilitaryNewsTV alloc] init];
    self.newsArray = militaryNewsArray;
    self.headerView.firstNewsArray = self.newsArray;
    self.tableView.delegate = self.militaryNewsTV;
    self.tableView.dataSource = self.militaryNewsTV;
    self.militaryNewsTV.newsArray = self.newsArray;
    [self.tableView reloadData];

} fail:^(NSError *error) {
     NSLog(@"error = %@",error);
}];




}


#pragma mark ---------头条新闻滚动视图设置-----
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return ;
    }
    if ([scrollView isKindOfClass:[SNNewsItemView class]]) {
        return;
    }
    UIScrollView * secondScroll = [scrollView.subviews objectAtIndex:1];
    UIImageView * imageView = [secondScroll.subviews objectAtIndex:0];
   _currentIndex = [_headerView.imageArray indexOfObject:imageView];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return ;
    }
    if ([scrollView isKindOfClass:[SNNewsItemView class]]) {
        return;
    }
    CGPoint  offset = scrollView.contentOffset;
    if (offset.x < SCREENWIDTH) {
        [self scrollViewWillDidScrollRight:scrollView];
    }
    if (offset.x > SCREENWIDTH) {
        [self scrollViewWillDidScrollLeft:scrollView];
    }
}

- (void)scrollViewWillDidScrollRight:(UIScrollView *)scrollView
{
    UIScrollView * firstScroll = [scrollView.subviews objectAtIndex:0];
    if (_currentIndex == 0) {
        UIImageView * showImageView = [_headerView.imageArray lastObject];
        if (firstScroll.subviews.count == 0) {
            [firstScroll addSubview:showImageView];
        }else{
            [firstScroll.subviews.firstObject removeFromSuperview];
            [firstScroll addSubview:showImageView];
        }
    }else{
    UIImageView * showImageView = [_headerView.imageArray objectAtIndex:_currentIndex - 1];
        if (firstScroll.subviews.count == 0) {
            [firstScroll addSubview:showImageView];
        }else{
            [firstScroll.subviews.firstObject removeFromSuperview];
            [firstScroll addSubview:showImageView];
        }
    }
}
- (void)scrollViewWillDidScrollLeft:(UIScrollView *)scrollView
{
    UIScrollView * thirdScroll = [scrollView.subviews objectAtIndex:2];
    if (_currentIndex == _headerView.imageArray.count - 1) {
        UIImageView * showImageView = [_headerView.imageArray firstObject];
        if (thirdScroll.subviews.count == 0) {
            [thirdScroll addSubview:showImageView];
        }else{
            [thirdScroll.subviews.firstObject removeFromSuperview];
            [thirdScroll addSubview:showImageView];
        }
    }else{
        UIImageView * showImageView = [_headerView.imageArray objectAtIndex:_currentIndex + 1];
        if (thirdScroll.subviews.count == 0) {
            [thirdScroll addSubview:showImageView];
        }else{
            [thirdScroll.subviews.firstObject removeFromSuperview];
            [thirdScroll addSubview:showImageView];
        }
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // ???:滚动图快速转动有问题
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        return ;
    }
    CGPoint  offset = scrollView.contentOffset;
    if ([scrollView isKindOfClass:[SNNewsItemView class]]) {
        
        
//        NSLog(@"______%ld",self.newsItemIndex);
//        if (self.newsItemIndex*60+30 < 160 ||self.newsItemIndex * 60 +30 > self.newsItemArray.count * 60 - 160) {
//            return;
//        }else{
//        // ???:动画优化
//        offset.x = self.newsItemIndex *60 +30 - 160;
//        scrollView.contentOffset = offset;
//        
//        return;
//        }
        return;
    }
    UIScrollView * firstScroll = [scrollView.subviews objectAtIndex:0];
    UIScrollView * secondScroll = [scrollView.subviews objectAtIndex:1];
    UIScrollView * thirdScroll = [scrollView.subviews objectAtIndex:2];
    if (offset.x == 0) {
        UIImageView * firstView = firstScroll.subviews.firstObject;
        [secondScroll.subviews.firstObject removeFromSuperview];
        [secondScroll addSubview:firstView];
        
        offset.x = SCREENWIDTH;
        scrollView.contentOffset = offset;
    }
    if (offset.x == 2 * SCREENWIDTH) {
        UIImageView * thirdView = thirdScroll.subviews.firstObject;
        [secondScroll.subviews.firstObject removeFromSuperview];
        [secondScroll addSubview:thirdView];
        offset.x = SCREENWIDTH;
        scrollView.contentOffset = offset;
    }
}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    return [self.newsArray count];
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//   // SNLocalNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
//    SNHeaderNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
//    
//    if (nil != news.imgExtraArray) {
//        static NSString * imageIdentifier = @"imageCell";
//        SNShowImageCell * cell =  [tableView dequeueReusableCellWithIdentifier:imageIdentifier];
//        if (!cell) {
//            cell = [[SNShowImageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:imageIdentifier];
//        }
//        cell.news = news;
//        return cell;
//    }
//    
//    static NSString * identifier = @"cell";
//    SNNormalNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//    if (!cell) {
//        cell = [[[SNNormalNewsCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
//    }
//    cell.news = news;
//    
//    return cell;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    SNHeaderNewsModel * news = [self.newsArray objectAtIndex:indexPath.row];
//    if (nil != news.imgExtraArray) {
//        return 100;
//    }
//    return 70;
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
