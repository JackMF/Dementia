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
#import "ParticipantDetailsFormViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
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
	[self setTestLabelValue];
	[self.navigationController.navigationItem setLeftBarButtonItem:nil];
	[self setNavButton];
	[self setParticipantDetails];
	[self updateParticipantDetailsButton];
	[self updateTestButton];
	[self updateTestResultsButton];
}

-(void)updateTestResultsButton
{
	if (![testManager participantName] || ![testManager hasStarted])
		[testResultsButton setEnabled:NO];
	else [testResultsButton setEnabled:YES];
}

-(void)updateTestButton
{
	if (![testManager participantName])
		[testButton setEnabled:NO];
	else {
		[testButton setEnabled:YES];
		if (![testManager hasStarted])
			[testButton setTitle:@"Start Test" forState:UIControlStateNormal];
		else
			[testButton setTitle:@"Continue Test" forState:UIControlStateNormal];
	}
}

-(void)updateParticipantDetailsButton
{
	if (![testManager participantName])
		[participantDetailsButton setTitle:@"Enter Participant Details" forState:UIControlStateNormal];
	else
		[participantDetailsButton setTitle:@"Edit Participant Details" forState:UIControlStateNormal];
}
-(void)setNavButton
{
	UIBarButtonItem *listButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(menuButtonPressed)];
	self.navigationItem.rightBarButtonItem = listButton;
}

-(void)menuButtonPressed
{
	UIActionSheet *menuActionSheet = [[UIActionSheet alloc]
	    initWithTitle:@"Menu"
	    delegate:self
	    cancelButtonTitle:@"Cancel"
	    destructiveButtonTitle:nil
	    otherButtonTitles:
	    @"Choose Test...",
	    @"Cancel",
	    nil];
	[menuActionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0) {
		[self showDebugViewController];
	}
}

-(void)showDebugViewController
{
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:debugViewController];
	[self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)enterParticipantDetailsButtonPressed:(id)sender {
	ParticipantDetailsFormViewController *participantDetailsFormViewController = [[ParticipantDetailsFormViewController alloc] initWithNibName:@"ParticipantDetailsFormViewController" bundle:nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:participantDetailsFormViewController];
	[self presentViewController:navController animated:YES completion:nil];
}

-(void)setParticipantDetails
{
	[participantNameLabel setText:[testManager participantName]];
	[participantHospitalNumberLabel setText:[testManager participantHospitalNoOrAddress]];
}

- (IBAction)testButtonPressed {
	[self showCurrentTest];
}

-(void)showCurrentTest
{
	// Start the test, loading views on the navigation controller
	Test *nextText = [[testManager tests] objectAtIndex:[testManager currentTestOrder]];
	[nextText launchWithNavigationController:self.navigationController];
}

- (IBAction)endButtonPressed {
	ResultsViewController *resultsViewController = [[ResultsViewController alloc] initWithNibName:@"ResultsViewController" bundle:nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:resultsViewController];
	[self presentViewController:navController animated:YES completion:nil];
}

-(void)setTestLabelValue
{
	[participantDetailsView setHidden:(![testManager participantName] || ![testManager participantHospitalNoOrAddress])];
	[progressLabel setText:[NSString stringWithFormat:@"%i/%i tests completed", [testManager currentTestOrder], (int) [tests count]]];
	Test *nextText = [[testManager tests]objectAtIndex:[testManager currentTestOrder]];
	NSString *name = [nextText getFullTestName];
	[currentTestLabel setText:name];
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
