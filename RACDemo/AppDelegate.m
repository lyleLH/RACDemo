//
//  AppDelegate.m
//  RACDemo
//
//  Created by 張帥 on 2016/7/14.
//  Copyright © 2016年 張帥. All rights reserved.
//

#import "AppDelegate.h"
#import "StatusViewController.h"
#import <WeiboSDK.h>
#import "WeiboAccount.h"

@interface AppDelegate () <WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIViewController *viewController = [[StatusViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = mainNavigationController;
    [self.window makeKeyAndVisible];
    
    // Sina Weibo register
    [WeiboSDK registerApp:WeiBoAppKey];
    
    return YES;
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSString *string = [url absoluteString];
    if ([string hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else {
        return NO;
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    NSString *string = [url absoluteString];
    if ([string hasPrefix:@"wb"]) {
        return [WeiboSDK handleOpenURL:url delegate:self];
    } else {
        return NO;
    }
}

// Sina Weibo callback
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBAuthorizeResponse.class]) {
        ZSLog("%@", response.userInfo);
        WBAuthorizeResponse *res = (WBAuthorizeResponse *)response;
        WeiboAccount *account = [WeiboAccount new];
        account.uid = res.userID;
        account.expiresTime = res.expirationDate;
        account.access_token = res.accessToken;
        account.refresh_token = res.refreshToken;
        [account saveAccount];
        
        [self.authorizeCompletionSignal sendNext:nil];
        [self.authorizeCompletionSignal sendCompleted];
    }
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request {
    
}

- (RACSubject *)authorizeCompletionSignal {
    if (!_authorizeCompletionSignal) {
        _authorizeCompletionSignal = [RACSubject subject];
    }
    return _authorizeCompletionSignal;
}

@end
