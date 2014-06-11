//
//  FluencyLetterSViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 24/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "FluencyLetterSViewController.h"
#import "Test.h"
#import "CountdownTimerViewController.h"

@interface FluencyLetterSViewController ()

@end

@implementation FluencyLetterSViewController
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
}

-(void)viewWillAppear:(BOOL)animated
{
	[self addTimerViewController];
}

-(void)addTimerViewController
{
	timerViewController = [[CountdownTimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil];
	CGRect timerFrame = CGRectMake(100.0f, 100.0f, 600.0f, 200.0f);
	[timerViewController.view setFrame:timerFrame];
	[self addChildViewController:timerViewController];
	[timerViewController setTestVCDelegate:self];
	[timerViewController didMoveToParentViewController:self];
	[self.view addSubview:timerViewController.view];
}

-(void)timerHasFinished
{
	NSLog(@"timer Finished");
	[self displayFinishedAlertView];
}

-(void)displayFinishedAlertView
{

	finishedAlertView = [UIAlertView new];
	[finishedAlertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
	[finishedAlertView setTitle:@"How many words did the participant produce?"];
	[finishedAlertView addButtonWithTitle:@"Cancel"];
	[finishedAlertView addButtonWithTitle:@"Enter"];
	[finishedAlertView setDelegate:self];

	UITextField *textField = [finishedAlertView textFieldAtIndex:0];
	[textField setDelegate:self];
	[textField setClearButtonMode:UITextFieldViewModeAlways];
	textField.text = @"";
	[finishedAlertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 1) {
		UITextField *numberField = [alertView textFieldAtIndex:0];
		[self finishWithScore:numberField.text];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[finishedAlertView dismissWithClickedButtonIndex:0 animated:YES];
	[self finishWithScore:textField.text];
	return YES;
}

-(void)finishWithScore:(NSString *)score
{
	int testScore = (int)[score integerValue];
	[test addToTestScore:testScore];
	[super hasFinished];
}

-(void)viewWillDisappear:(BOOL)animated
{
	timerViewController.view = nil;
	[timerViewController removeFromParentViewController];
	timerViewController = nil;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
