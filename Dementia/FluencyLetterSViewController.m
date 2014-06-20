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
	[self setSeg];
}

-(void)setSeg
{
//	CGRect frame = speakingWritingSegmentedControl.frame;
//	[speakingWritingSegmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 50.0f)];
	UIFont *font = [UIFont boldSystemFontOfSize:26.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
	[speakingWritingSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (IBAction)speakingWritingValueChanged {
	int newIndex = [speakingWritingSegmentedControl selectedSegmentIndex];
	if (newIndex==0) duration=kSpeakingDurationSeconds;
	else if (newIndex==1) duration=kWritingDurationSeconds;
	[self setSeg];
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
	int score = [self calculateScore];
	if (score!=-1) {
		[test addToTestScore:score];
		[super hasFinished];
	} else {
		[self addCountdownTimer];
		[self addTimer];
	}
}

-(int)calculateScore
{
	if (numberOfWordsProduced && duration && repeatDuration)
		return (duration - repeatDuration) / numberOfWordsProduced;
	else return -1;
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


-(void)viewWillDisappear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
