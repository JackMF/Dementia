//
//  ExecutiveReverseDigitSpanViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 24/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExecutiveReverseDigitSpanViewController.h"
#import "TestViewController.h"
#import "Test.h"


@interface ExecutiveReverseDigitSpanViewController ()

@end

@implementation ExecutiveReverseDigitSpanViewController
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
    digitsArray = [test Digits];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end