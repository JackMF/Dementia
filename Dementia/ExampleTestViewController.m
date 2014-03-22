//
//  ExampleTestViewController.m
//  Dementia
//
//  Created by Chris on 16/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExampleTestViewController.h"

@interface ExampleTestViewController ()

@end

@implementation ExampleTestViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Example Test";
    }
    return self;
}

- (void)viewDidLoad
{
    currentScore = 0;
    [super viewDidLoad];
    [infoLabel setText:@"Press the button below to finish the test"];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)finishButtonPressed
{
    [super hasFinished];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pressMeButtonPressed:(id)sender {
    currentScore++;
    NSLog(@"Score: %i", currentScore);
    
}

@end
