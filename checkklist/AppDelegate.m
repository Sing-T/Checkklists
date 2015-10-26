//
//  AppDelegate.m
//  checkklist
//
//  Created by 王新涛 on 29/9/15.
//  Copyright © 2015 sin. All rights reserved.
//

#import "AppDelegate.h"
#import "AllListsViewController.h"
#import "DataModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate{
    DataModel *_dataModel;
}

-(void)saveData{
//    UINavigationController *navigationController = (UINavigationController*)self.window.rootViewController;
//    AllListsViewController *controller = navigationController.viewControllers[0];
    [_dataModel saveChecklists];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    //NSLog(@"didReceivedLocalNotification %@",notification);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _dataModel = [[DataModel alloc]init];
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    AllListsViewController *controller = navigationController.viewControllers[0];
    controller.dataModel = _dataModel;
    
    //local notification
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
//    UILocalNotification *localNotification = [[UILocalNotification alloc]init];
//    
//    localNotification.fireDate = date;
//    localNotification.timeZone = [NSTimeZone defaultTimeZone];
//    localNotification.alertBody = @"2014年到了,⻢马上有钱!";
//    localNotification.soundName = UILocalNotificationDefaultSoundName;
//    
//    [[UIApplication sharedApplication]scheduleLocalNotification:localNotification];
    
    float sysVersion=[[UIDevice currentDevice]systemVersion].floatValue;
    if (sysVersion>=8.0) {
        UIUserNotificationType type=UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIUserNotificationTypeSound;
        UIUserNotificationSettings *setting=[UIUserNotificationSettings settingsForTypes:type categories:nil];
        [[UIApplication sharedApplication]registerUserNotificationSettings:setting];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [self saveData];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self saveData];
}

@end
