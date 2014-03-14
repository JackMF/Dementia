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
-(id)initWithTest:(TestViewController *)initTestViewController navigationController:(UINavigationController *)initNavController
{
    if (self = [super init]) {
        // Set our test controller
        testViewController = initTestViewController;
        testViewController.test = self;
        
        // Set our pre-test controller
        preTestViewController = [[PreTestViewController alloc] initWithNibName:@"PreTestViewController" bundle:nil];
        preTestViewController.test = self;
        
        // Set our post-test controller
        postTestViewController = [[PostTestViewController alloc] initWithNibName:@"PostTestViewController" bundle:nil];
        postTestViewController.test = self;

        // Set our navigation controller
        navigationController = initNavController;
    }
    return self;
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
