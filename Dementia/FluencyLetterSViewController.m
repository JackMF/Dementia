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
#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 120.0f

@interface FluencyLetterSViewController ()

@end

@implementation FluencyLetterSViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		duration = kSpeakingDurationSeconds;
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

-(void)viewDidDisappear:(BOOL)animated
{
	[self removeTimers];
}

-(void)viewDidLayoutSubviews
{
	[self setDurationControl];
}

-(void)setDurationControl
{
	UIFont *font = [UIFont boldSystemFontOfSize:26.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
	[speakingWritingSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (IBAction)speakingWritingValueChanged {
	int newIndex = (int) [speakingWritingSegmentedControl selectedSegmentIndex];
	if (newIndex==0) duration=kSpeakingDurationSeconds;
	else if (newIndex==1) duration=kWritingDurationSeconds;
	[self setDurationControl];
	[self addCountdownTimer];
}

-(void)addCountdownTimer
{
	if (countdownTimerViewController) {
		[countdownTimerViewController removeFromParentViewController];
		countdownTimerViewController.view = nil;
		countdownTimerViewController = nil;
	}

	countdownTimerViewController = [[CountdownTimerViewController alloc] initWithNibName:@"CountdownTimerViewController" bundle:nil];
	CGRect timerFrame = CGRectMake(84.0f, 235.0f, 600.0f, 90.0f);
	[countdownTimerViewController.view setFrame:timerFrame];
	[countdownTimerViewController setTestVCDelegate:self];

	[self addChildViewController:countdownTimerViewController];
	[countdownTimerViewController setCountdownDuration:duration];
	[countdownTimerViewController didMoveToParentViewController:self];
	[self.view addSubview:countdownTimerViewController.view];
}

-(void)addTimer
{

	if (timerViewController) {
		[timerViewController removeFromParentViewController];
		timerViewController.view = nil;
		timerViewController = nil;
	}
	timerViewController = [[TimerViewController alloc] initWithNibName:@"TimerViewController" bundle:nil];
	CGRect timerFrame = CGRectMake(84.0f, 550.0f, 600.0f, 90.0f);
	[timerViewController.view setFrame:timerFrame];
	[timerViewController setTestVCDelegate:self];

	[self addChildViewController:timerViewController];
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
	double vfi = [super getVFIFromNumberOfWordsProduced:numberOfWordsProduced duration:duration repeatDuration:repeatDuration];
	int score = [self getScoreFromVFI:vfi];
	if (score!=-1) {
		[test setVfi:[NSNumber numberWithDouble:vfi]];
		[test addToTestScore:score];
		[super hasFinished];
	} else {
		[self addCountdownTimer];
		[self addTimer];
	}
}

-(void)removeTimers
{
	countdownTimerViewController.view = nil;
	[countdownTimerViewController removeFromParentViewController];
	countdownTimerViewController = nil;

	timerViewController.view = nil;
	[timerViewController removeFromParentViewController];
	timerViewController = nil;
}

-(int)getScoreFromVFI:(double)vfi
{
	if (duration==kSpeakingDurationSeconds) {
		if (vfi >= 12) return 0;
		else if (vfi >= 10) return 2;
		else if (vfi >= 8) return 4;
		else if (vfi >= 6) return 6;
		else if (vfi >= 4) return 8;
		else if (vfi >= 2) return 10;
		else if (vfi < 2) return 12;
	} else if (duration==kWritingDurationSeconds) {
		if (vfi >= 20) return 0;
		else if (vfi >= 16.5) return 2;
		else if (vfi >= 13.0) return 4;
		else if (vfi >= 9.5) return 6;
		else if (vfi >= 6.0) return 8;
		else if (vfi >= 2.5) return 10;
		else if (vfi < 2.5) return 12;
	}
	return -1;
}


-(void)viewWillDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
