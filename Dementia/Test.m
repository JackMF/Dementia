//
//  Test.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "Test.h"
#import "PreTestViewController.h"
#import "PostTestViewController.h"
#import "TestViewController.h"
#import <UIKit/UIKit.h>


@implementation Test
@synthesize testViewController;
@synthesize testScore;
@synthesize order, className, categoryName, testName, preTestInstructions, postTestInstructions, imageDictionaries;

-(id)initWithPlistDict:(NSDictionary *)plistDict
{
    if (self = [super init]) {
        order = [[plistDict valueForKey:@"order"] integerValue];
        className = [plistDict valueForKey:@"className"];
        categoryName = [plistDict valueForKey:@"categoryName"];
        testName = [plistDict valueForKey:@"testName"];
        preTestInstructions = [plistDict valueForKey:@"preTestInstructions"];
        postTestInstructions = [plistDict valueForKey:@"postTestInstructions"];
        imageDictionaries = [plistDict valueForKey:@"imageDictionaries"];
       
        // Set our test controller
        testViewController = [[NSClassFromString(className) alloc] init];
        testViewController.test = self;
        
        // Set our pre-test controller
        preTestViewController = [[PreTestViewController alloc] initWithNibName:@"PreTestViewController" bundle:nil];
        preTestViewController.test = self;
        // Set our post-test controller
        postTestViewController = [[PostTestViewController alloc] initWithNibName:@"PostTestViewController" bundle:nil];
        postTestViewController.test = self;
        
        // Set our navigation controller
//        navigationController = initNavController;
    }
    return self;
}

-(void)launchWithNavigationController:(UINavigationController *)navController
{
    navigationController = navController;
    [self startPreTest];
}

-(void)startPreTest
{
    [navigationController pushViewController:preTestViewController animated:YES];
}

-(void)startTest
{
    [navigationController pushViewController:(UIViewController *)testViewController animated:YES];
}

-(void)startPostTest
{
    [navigationController pushViewController:postTestViewController animated:YES];
}

-(void)endTest
{
    [navigationController popToRootViewControllerAnimated:YES];
}

@end
