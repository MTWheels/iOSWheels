//
//  AppDelegate.m
//  iOSWheels
//
//  Created by 方新俊 on 2018/3/29.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"Debug101_200_75_215" ofType:@"cer"];
    [MTNetworkHelper setSecurityPolicyWithCerPath:cerPath validatesDomainName:NO];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
    
}


@end
