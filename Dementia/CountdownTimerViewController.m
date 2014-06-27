//
//  TimerViewController.m
//  Dementia
//
//  Created by Chris on 10/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "CountdownTimerViewController.h"
#import "TestViewController.h"

#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 120.0f

@interface CountdownTimerViewController ()

@end

@implementation CountdownTimerViewController
@synthesize testVCDelegate;
@synthesize countdownDuration;
int minutes, seconds;
int secondsRemaining;

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
	secondsRemaining = countdownDuration;
	[self updateCountdownLabel];
	[self setDurationControl];
	[super viewWillAppear:animated];
}

-(void)viewDidLayoutSubviews
{
	[self setDurationControl];
	[super viewDidLayoutSubviews];
}

- (IBAction)speakingWritingValueChanged {
	int newIndex = (int) [speakingWritingSegmentedControl selectedSegmentIndex];
	if (newIndex==0) {
		secondsRemaining = kSpeakingDurationSeconds;
	} else if (newIndex==1) {
		secondsRemaining = kWritingDurationSeconds;
	}
	[self setCountdownDuration:secondsRemaining];
	[testVCDelegate setDuration:[self countdownDuration]];
	[self setDurationControl];
	[self updateCountdownLabel];
}

-(void)setDurationControl
{
	UIFont *font = [UIFont boldSystemFontOfSize:26.0f];
	NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
	[speakingWritingSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (IBAction)startButtonPressed:(id)sender {
	countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
	[startButton setEnabled:NO];
	[speakingWritingSegmentedControl setEnabled:NO];
}

- (IBAction)stopButtonPressed:(id)sender {
	[self timerHasFinished];
}

-(void)updateCountdownLabel
{
	NSString *labelText;
	if(secondsRemaining > 0 ) {
		minutes = (secondsRemaining % 3600) / 60;
		seconds = (secondsRemaining %3600) % 60;
		labelText = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
		countdownLabel.text = labelText;
		secondsRemaining--;
	} else {
		labelText = @"00:00";
		countdownLabel.text = labelText;
		[self timerHasFinished];
	}
}

-(void)timerHasFinished
{
	[countdownTimer invalidate];
	if (testVCDelegate)
		[testVCDelegate countdownTimerHasFinished];
}

-(void)viewWillDisappear:(BOOL)animated
{
	[countdownTimer invalidate];
}

-(void)willMoveToParentViewController:(UIViewController *)parent
{
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
