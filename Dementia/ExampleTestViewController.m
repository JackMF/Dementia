//
//  ExampleTestViewController.m
//  Dementia
//
//  Created by Chris on 16/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExampleTestViewController.h"
#import "ButtonListViewController.h"
#import "Test.h"

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
	[super viewDidLoad];
	currentScore = 0;
	[infoLabel setText:@"Press the button below to finish the test"];
	buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	// Add the control panel to the view
	[self addChildViewController:buttonListViewController];

	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 485.0, 768.0, 185.0);
	[buttonListViewController.view setFrame:cpFrame];


	NSArray *buttonLabelValues = @[@"1-A",@"2-B",@"3-C",@"4-D",@"5-E",@"6-F",@"7-G"];
	[buttonListViewController setButtonLabelValues:buttonLabelValues];

	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];

}

-(IBAction)finishButtonPressed
{
	NSInteger correct = [buttonListViewController getNumberOfCorrectAnswers];
	[test addToTestScore:correct];
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
