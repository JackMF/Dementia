//
//  MemoryRecallViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryRecallViewController.h"
#import "Test.h"

@interface MemoryRecallViewController ()

@end

@implementation MemoryRecallViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end