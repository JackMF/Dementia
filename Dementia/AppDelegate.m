//
//  AppDelegate.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "AppDelegate.h"
#import "DebugViewController.h"
#import "TestManager.h"
#import "ExampleTestViewController.h"
#import "MemoryRecallViewController.h"
@implementation AppDelegate

// THE ENTRY POINT
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Create an instance of the test manager
    [TestManager sharedInstance];


    // Instantiate our debug view controller (displays all tests in a list)
    DebugViewController *debug = [[DebugViewController alloc] initWithNibName:@"DebugViewController" bundle:nil];
    // Instatiate a navigation controller
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:debug];
    [navController setTitle:@"DEBUG"];
    
    // Instantiate the ExampleTextViewController (for in-progress test view controllers)
    ExampleTestViewController *exTestVC = [[ExampleTestViewController alloc] initWithNibName:@"ExampleTestViewController" bundle:nil];
    
    MemoryRecallViewController *ir = [[MemoryRecallViewController alloc] initWithNibName:@"MemoryRecallViewController" bundle:nil];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];   // Make a tab bar controller
    [tabBarController setViewControllers:@[navController, exTestVC]];           // Set it's view controllers
    // Set the root view controller of our window to the tab bar controller
    [self.window setRootViewController:tabBarController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when	 the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
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
