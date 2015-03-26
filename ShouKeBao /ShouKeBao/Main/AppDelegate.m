//
//  AppDelegate.m
//  ShouKeBao
//
//  Created by David on 15/3/12.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import "AppDelegate.h"
#import "Login.h"
#import "ViewController.h"
#import "WMNavigationController.h"
#import "LoginTool.h"
#import "UserInfo.h"

@interface AppDelegate ()

@property (nonatomic,assign) BOOL isAutoLogin;

@property (nonatomic,strong) NSCondition *itlock;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.isAutoLogin = NO;
    
    // 判断是否已绑定账号
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *phone = [def objectForKey:@"phonenumber"];
    NSString *password = [def objectForKey:@"password"];
    if (phone.length && password.length) {
        
        [self autoLoginWithPhone:phone password:password];
    }else{
        self.isAutoLogin = NO;
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (self.isAutoLogin) {
        [self setTabbarRoot];
    }else{
        [self setLoginRoot];
    }
    
    return YES;
}

#pragma public
-(void)setTabbarRoot
{
    ViewController *vc = [[ViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

-(void)setLoginRoot
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Auth" bundle:nil];
    Login *lg = [sb instantiateViewControllerWithIdentifier:@"Login"];
    WMNavigationController *nav = [[WMNavigationController alloc] initWithRootViewController:lg];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}

#pragma mark - private
- (void)autoLoginWithPhone:(NSString *)phone password:(NSString *)password
{
    NSDictionary *param = @{@"LoginName":phone,
                            @"LoginPassword":password};
    [LoginTool syncLoginWithParam:param success:^(id json) {
        NSLog(@"----%@",json);
        
        if ([json[@"IsSuccess"] integerValue] == 1) {
            
            [UserInfo userInfoWithDict:json];
            
            self.isAutoLogin = YES;
        }

    } failure:^(NSError *error) {
        
    }];
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
