//
//  ExecutiveAlternationViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 25/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExecutiveAlternationViewController.h"
#import "Test.h"
#import "ButtonListViewController.h"
@interface ExecutiveAlternationViewController ()

@end

@implementation ExecutiveAlternationViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    buttonText = [test buttonText];
    
    
    buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	// Add the control panel to the view
	[self addChildViewController:buttonListViewController];
    
	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 485.0, 768.0, 185.0);
	[buttonListViewController.view setFrame:cpFrame];
    
	NSArray *buttonLabelValues = buttonText;
	[buttonListViewController setButtonLabelValues:buttonLabelValues];
    
	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];
    
    
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

- (IBAction)finishButtonPressed:(id)sender {
    [test addToTestScore:[buttonListViewController getNumberOfCorrectAnswers]];
    [super hasFinished];
    
}
@end
