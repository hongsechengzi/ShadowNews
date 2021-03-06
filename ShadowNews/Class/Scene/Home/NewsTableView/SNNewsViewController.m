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

#import "SNMainMenu.h"

#import "SNNomarlNewsModel.h"
#import "SNNomarlNewsPageModel.h"
#import "SNNomarlNewsTV.h"
#import "SNHomeConst.h"

#import "SNLocalNewsTV.h"
#import "SNSimpleNewsTV.h"
#import "SNSimplePageModel.h"
#import "SNHeaderNewsTV.h"

#import "SNCategoryViewController.h"
#import "SNUserViewController.h"
#import "SNNewsTableView.h"
#import "SNPolViewController.h"



@interface SNNewsViewController ()

@property(nonatomic,assign)NSInteger currentIndex;//!<当前头条新闻图像下标
@property(nonatomic,retain)SNNewsTableView * tableView;//!表视图
@property(nonatomic,retain)NSMutableArray * newsMenuArray;//!<菜单数组


@property(nonatomic,retain)SNNomarlNewsTV * nomarlNewsTV;
@property(nonatomic,retain)SNLocalNewsTV * localNewsTV;//!<执行本地新闻tableview代理方法的对象
@property(nonatomic,retain)SNSimpleNewsTV * simpleNewsTV;
@property(nonatomic,retain)SNHeaderNewsTV * headerNewsTV;

@end

@implementation SNNewsViewController
- (void)dealloc
{
   // RELEASE_SAFELY(_headerView);
    RELEASE_SAFELY(_newsItemScroll);
    RELEASE_SAFELY(_newsArray);
    RELEASE_SAFELY(_tableView);
    self.nomarlNewsTV = nil;
    self.newsMenuArray = nil;
    self.simpleNewsTV = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            self.automaticallyAdjustsScrollViewInsets = NO;
    
    }
    return self;
}
- (void)loadView
{
    SNNewsView * newsView = [[SNNewsView alloc] init];
    newsView.delegate = self;
    newsView.dataSource = self;
    self.view = newsView;
    SNRelease(newsView);
}
- (void)viewDidLoad
{
    // NSLog(@"%@",self.tableView);
    [super viewDidLoad];
     self.title = @"ShadowNews";
    [self setupNormalSubviews];
   // [self.headerNewsTV handleHeaderPageData];
    [self setupItemButton];
 
    
    self.newsItemScroll = [[[SNNewsItemView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SNNewsViewMenuHeight)] autorelease];
    self.newsItemScroll.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.newsItemScroll];
//    self.newsItemScroll.showsVerticalScrollIndicator = NO;
//    self.newsItemScroll.showsHorizontalScrollIndicator = NO;
//    self.newsItemScroll.delegate = self;

    
    NSArray * newsArr = [self.newsMenuDic allKeys];
    self.newsMenuArray = [NSMutableArray arrayWithArray:newsArr];
    [self.newsMenuArray insertObject:@"头条" atIndex:0];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:self.newsMenuArray];
    segment.frame = CGRectMake(0, 0,self.newsMenuArray.count * 60, SNNewsViewMenuHeight);
    [self.newsItemScroll addSubview:segment];
//    self.newsItemScroll.contentSize = CGSizeMake(self.newsMenuArray.count * 60, SNNewsViewMenuHeight);
    [segment addTarget:self action:@selector(didClickSegmentControlAction:) forControlEvents:UIControlEventValueChanged];
}
#pragma mark -------------合代码
- (SNNewsTableView *)newsView:(SNNewsView *)newsView
                 viewForTitle:(NSString *) title
                      preLoad:(BOOL) preLoad
{
    // !!!:下一步要做的事: 为不同的页面板块,返回"不同"的SNNewsTabelView对象即可.
//    UILabel * label = [[UILabel alloc] init];
//    label.text = title;
//    return label;
    
    SNNewsTableView * tableView = [[SNNewsTableView alloc] initWithTitle:title preLoad:YES];
    [self addDelegateForCell:tableView];
    return tableView;
    
    // !!!:无法轮转的原因:始终返回同一个 tableView.
//    return self.tableView;
}
- (NSArray *) menuInNewsView: (SNNewsView *) newsView
{

    return self.newsMenuArray;

}



- (void)addDelegateForCell: (SNNewsTableView *) tableView
{



}



#pragma mark ---布局BarItem按钮
- (void)setupItemButton
{
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:SNHeaderLeftBarItemImage] style:UIBarButtonItemStylePlain target:self action:@selector(didClickLeftBarItemAction:)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [leftButtonItem release];
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:SNHeaderLeftBarItemImage] style:UIBarButtonItemStylePlain target:self action:@selector(didClickRightBarItemAction:)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    [rightButtonItem release];
}
- (void)didClickLeftBarItemAction:(UIBarButtonItem *)buttonItem
{
    SNCategoryViewController * catergory = [[SNCategoryViewController alloc] init];
    [self presentViewController:catergory animated:YES completion:nil];
    [catergory release];
   
}
- (void)didClickRightBarItemAction:(UIBarButtonItem *)buttonItem
{
    
}
#pragma mark -----布局子视图
- (void)setupNormalSubviews
{
   // self.tableView = [[[SNNewsTableView alloc] initWithFrame:CGRectMake(5, SNNewsViewMenuHeight, SCREENWIDTH-10, SCREENHEIGHT)] autorelease];
    
    self.tableView = [[[SNNewsTableView alloc] init] autorelease];
    
   // self.tableView.headerView.scrollView.delegate = self;
    

    self.headerNewsTV =[[SNHeaderNewsTV alloc] initWithTableView:self.tableView];
   // self.headerNewsTV.tableView = self.tableView;
    [self.headerNewsTV handleHeaderPageData];
    [self.view addSubview:self.tableView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------选择新闻菜单的分段控件设置
- (void)didClickSegmentControlAction:(UISegmentedControl *)segmentControl
{
    
    self.tableView.headerView.scrollView.delegate = self;    
    NSString *  selectItem = [self.newsMenuArray objectAtIndex:segmentControl.selectedSegmentIndex];
   // NSLog(@"selectitem = %@",selectItem);
   
    if ([selectItem isEqualToString:@"头条"]) {
        
         self.headerNewsTV = [[[SNHeaderNewsTV alloc] initWithTableView:self.tableView] autorelease];
        [self.headerNewsTV handleHeaderPageData];
    }else{
      
     SNMainMenu * oneNewsMenu = [self.newsMenuDic objectForKey:selectItem];
        NSLog(@"oneNewsMenu.pageKey =%@",oneNewsMenu.pageKey);
        if ([oneNewsMenu.pageKey isEqualToString:SNMainMenuNormalPageKey]) {
            self.nomarlNewsTV = [[[SNNomarlNewsTV alloc] initWithTableView:self.tableView] autorelease];
            self.nomarlNewsTV = [[SNNomarlNewsTV alloc] initWithTableView:self.tableView];
            
            [self.nomarlNewsTV handlePageDataWithMainMenu:oneNewsMenu];
        }        
        if ([oneNewsMenu.pageKey isEqualToString:SNMainMenuSimplePageKey]) {
            self.simpleNewsTV = [[[SNSimpleNewsTV alloc] initWithTableView:self.tableView] autorelease];
            [self.simpleNewsTV
             handlePageDataWithMainMenu:oneNewsMenu];
            
            }
        if ([oneNewsMenu.pageKey isEqualToString:SNMainMenuLocalPageKey]) {
            self.localNewsTV = [[[SNLocalNewsTV alloc] initWithTableView:self.tableView] autorelease];
            [self.localNewsTV handlePageDataWithMainMenu:oneNewsMenu];
        }
        if ([oneNewsMenu.pageKey isEqualToString:SNMainMenuPolymerizationPageKey]) {
          // [self.tableView removeFromSuperview];
            
            SNPolViewController * polVC = [[SNPolViewController alloc] init];
            polVC.view.frame =CGRectMake(5, SNNewsViewMenuHeight, SCREENWIDTH-10, SCREENHEIGHT);
            [self.view addSubview:polVC.collectionView];
        }
     }
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
   _currentIndex = [self.tableView.headerView.imageArray indexOfObject:imageView];
    
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
        UIImageView * showImageView = [self.tableView.headerView.imageArray lastObject];
        if (firstScroll.subviews.count == 0) {
            [firstScroll addSubview:showImageView];
        }else{
            [firstScroll.subviews.firstObject removeFromSuperview];
            [firstScroll addSubview:showImageView];
        }
    }else{
    UIImageView * showImageView = [self.tableView.headerView.imageArray objectAtIndex:_currentIndex - 1];
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
    if (_currentIndex == self.tableView.headerView.imageArray.count - 1) {
        UIImageView * showImageView = [self.tableView.headerView.imageArray firstObject];
        if (thirdScroll.subviews.count == 0) {
            [thirdScroll addSubview:showImageView];
        }else{
            [thirdScroll.subviews.firstObject removeFromSuperview];
            [thirdScroll addSubview:showImageView];
        }
    }else{
        UIImageView * showImageView = [self.tableView.headerView.imageArray objectAtIndex:_currentIndex + 1];
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
