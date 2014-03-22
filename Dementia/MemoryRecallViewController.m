//
//  MemoryRecallViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryRecallViewController.h"
#import "Test.h"
#import "ButtonListViewController.h"

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


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = [test getFullTestName];

	buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	// Add the control panel to the view
	[self addChildViewController:buttonListViewController];

	CGRect cpFrame = CGRectMake(150.0, 300.0, 478.0, 700.0);
	[buttonListViewController.view setFrame:cpFrame];

	NSArray *buttonLabelValues = [test buttonNames];
	[buttonListViewController setButtonLabelValues:buttonLabelValues];

	[buttonListViewController setOneItemPerRow:YES];

	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];

	[storyTextView setText:[test story]];
	[storyTextView setFont:[UIFont systemFontOfSize:24.0]];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)finishButtonPressed:(id)sender {
	int corrent = [buttonListViewController getNumberOfCorrectAnswers];
	[test addToTestScore:corrent];
	[super hasFinished];
}
@end
