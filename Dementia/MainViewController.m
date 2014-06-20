//
//  MainViewController.m
//  Dementia
//
//  Created by Chris on 19/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MainViewController.h"
#import "Test.h"
#import "TestManager.h"
#import "DebugViewController.h"
#import "ResultsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		currentTestOrder = 0;
		// Create an instance of the test manager
		testManager = [TestManager sharedInstance];
		tests = [testManager tests];
		debugViewController = [[DebugViewController alloc] initWithNibName:@"DebugViewController" bundle:nil];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
	if ([currentTest isComplete]) currentTestOrder++;
	currentTest = [tests objectAtIndex:currentTestOrder];                 // Get the test for this row
	[self setTestLabelValue];
	[self.navigationController.navigationItem setLeftBarButtonItem:nil];
	[self setNavButton];
}

-(void)setNavButton
{
	UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStyleBordered target:self action:@selector(showDebugViewController)];
	self.navigationItem.rightBarButtonItem = listButton;
}

-(void)showDebugViewController
{
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:debugViewController];
	[self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)continueButtonPressed {
	[self showCurrentTest];
}

- (IBAction)endButtonPressed {
	ResultsViewController *resultsViewController = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
	[self presentViewController:resultsViewController animated:YES completion:nil];
}

-(void)setTestLabelValue
{
	[progressLabel setText:[NSString stringWithFormat:@"%i/%i tests completed", currentTestOrder, [tests count]]];
	[currentTestLabel setText:[currentTest getFullTestName]];
}

-(void)showCurrentTest
{
	[currentTest launchWithNavigationController:self.navigationController];    // Start the test, loading views on the navigation controller
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
