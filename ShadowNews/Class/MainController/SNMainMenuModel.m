//
//  SNMianMenuModel.m
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNMainMenuModel.h"
#import "SNMainMenu.h"

@implementation SNMainMenuModel

+ (NSDictionary *)mianMenuDic
{
    SNMainMenu * entertainment = [SNMainMenu mainMenuTitle:@"娱乐" urlKeyStr:@"T1348648517839" url:@"http://c.3g.163.com/nc/article/list/T1348648517839/0-20.html" pageKey:@"normal"];
    SNMainMenu * sports = [SNMainMenu mainMenuTitle:@"体育" urlKeyStr:@"T1348649079062" url:@"http://c.3g.163.com/nc/article/list/T1348649079062/0-20.html" pageKey:@"normal"];
     SNMainMenu * money = [SNMainMenu mainMenuTitle:@"财经" urlKeyStr:@"T1348648756099" url:@"http://c.3g.163.com/nc/article/list/T1348648756099/0-20.html" pageKey:@"normal"];
     SNMainMenu * military = [SNMainMenu mainMenuTitle:@"军事" urlKeyStr:@"T1348648141035" url:@"http://c.3g.163.com/nc/article/list/T1348648141035/0-20.html" pageKey:@"simple"];
    
    SNMainMenu * local = [SNMainMenu mainMenuTitle:@"本地" urlKeyStr:@"local/5YyX5Lqs" url:@"http://c.3g.163.com/nc/article/local/5YyX5Lqs/0-20.html" pageKey:@"simple"];
    SNMainMenu * ploymerization = [SNMainMenu mainMenuTitle:@"聚合阅读" urlKeyStr:@"nc/tag/v2/list" url:@"http://c.3g.163.com/nc/tag/v2/list/all.html HTTP/1.1" pageKey:@"ploPage"];
    SNMainMenu * recommend = [SNMainMenu mainMenuTitle:@"推荐" urlKeyStr:@"recommend" url:@"http://c.3g.163.com/recommend/getSubDocNews?passport=&devId=860271025372117&size=20" pageKey:@"recommendPage"];
      NSDictionary * mianMenuDic =
    @{entertainment.title: entertainment,
      sports.title:sports,
      money.title:money,
      military.title:military,
      local.title:local,
      recommend.title:recommend,
      ploymerization.title:ploymerization
      };
    return mianMenuDic;
}


@end
