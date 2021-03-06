//
//  SNAppDelegate.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNAppDelegate.h"
#import "SNMainController.h"


#import "SNCategoryViewController.h"
#import "SNUserViewController.h"
#import "SNLoginViewController.h"
#import "SNLocalAddress.h"
#import "SNPolViewController.h"
#import "SNPolPageModel.h"


@implementation SNAppDelegate
- (void)dealloc
{
    RELEASE_SAFELY(_window);
    [super dealloc];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //测试左边栏
//    SNCategoryViewController * categoryVC = [[SNCategoryViewController alloc] init];
//   self.window.rootViewController = categoryVC;
    //测试右边栏个人
//    SNUserViewController * userVC = [[SNUserViewController alloc] init];
//    self.window.rootViewController = userVC;
    //测试登入页面
    
   
//    SNLoginViewController * userVC = [[SNLoginViewController alloc] init];
//    UINavigationController * rootNC = [[UINavigationController alloc] initWithRootViewController:userVC];
//    self.window.rootViewController = rootNC;
//     SNPolViewController * VC = [[SNPolViewController alloc] init];
//     self.window.rootViewController = VC ;

//     [SNPolPageModel polPageSuccess:^(NSDictionary * polDic) {
//         NSLog(@"headerNewsArray = %@",polDic);
//     } fail:^(NSError *error) {
//         NSLog(@"error:%@",error);
//     }];
    
   
    
    self.window.rootViewController = [[SNMainController sharedInstance] navController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
