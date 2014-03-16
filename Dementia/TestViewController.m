//
//  TestViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import "Test.h"

@interface TestViewController ()
@end

@implementation TestViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)hasFinishedTestWithScore:(int)testScore
{
    score = testScore;
    if (self.test) [self.test startPostTest]; // If we have a test, start the post test
    else {
        NSString *scoreString = [NSString stringWithFormat:@"%i points", score];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished! (debug mode)" message:scoreString delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
