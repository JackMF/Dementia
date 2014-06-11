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
#import "TimerViewController.h"

#define kTestDurationSeconds 5.0f
#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 60.0f

@interface FluencyLetterSViewController ()

@end

@implementation FluencyLetterSViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		duration = kTestDurationSeconds;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
	[self addCountdownTimer];
	[self addTimer];
}


-(void)addCountdownTimer
{
	countdownTimerViewController = [[CountdownTimerViewController alloc] initWithNibName:@"CountdownTimerViewController" bundle:nil];
	CGRect timerFrame = CGRectMake(100.0f, 100.0f, 600.0f, 200.0f);
	[countdownTimerViewController.view setFrame:timerFrame];
	[self addChildViewController:countdownTimerViewController];
	[countdownTimerViewController setTestVCDelegate:self];
	[countdownTimerViewController setCountdownDuration:duration];
	[countdownTimerViewController didMoveToParentViewController:self];
	[self.view addSubview:countdownTimerViewController.view];
}

-(void)addTimer
{
	timerViewController = [[TimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil];
	CGRect timerFrame = CGRectMake(100.0f, 500.0f, 600.0f, 200.0f);
	[timerViewController.view setFrame:timerFrame];
	[self addChildViewController:timerViewController];
	[timerViewController setTestVCDelegate:self];
	[timerViewController didMoveToParentViewController:self];
	[self.view addSubview:timerViewController.view];
}

-(void)countdownTimerHasFinished
{
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
		NSString *number = numberField.text;
		numberOfWordsProduced = (int)[number integerValue];
	}
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[finishedAlertView dismissWithClickedButtonIndex:0 animated:YES];
	NSString *number = textField.text;
	numberOfWordsProduced = (int)[number integerValue];
	return YES;
}

-(void)timerStoppedWithTimeElapsed:(int)timeElapsed
{
	repeatDuration = timeElapsed;
	int score = [self calculateScore];
	[test addToTestScore:score];
	[super hasFinished];
}

-(int)calculateScore
{
	return (duration - repeatDuration) / numberOfWordsProduced;
}


-(void)viewWillDisappear:(BOOL)animated
{
	countdownTimerViewController.view = nil;
	[countdownTimerViewController removeFromParentViewController];
	countdownTimerViewController = nil;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
