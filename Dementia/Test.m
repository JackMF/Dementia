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
@synthesize preTestViewController, testViewController, postTestViewController;
-(id)initWithPreTest:(PreTestViewController *)pre test:(TestViewController *)theTestViewController postTest:(PostTestViewController *)post navigationController:(UINavigationController *)navController
{
    if (self = [super init]) {
        // Set our pre-test controller
        self.preTestViewController = pre;
        self.preTestViewController.test = self;
        
        // Set our test controller
        self.testViewController = theTestViewController;
        self.testViewController.test = self;
        
        // Set our post-test controller
        self.postTestViewController = post;
        self.postTestViewController.test = self;

        // Set our navigation controller
        navigationController = navController;
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
