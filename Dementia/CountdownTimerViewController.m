//
//  TimerViewController.m
//  Dementia
//
//  Created by Chris on 10/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "CountdownTimerViewController.h"
#import "TestViewController.h"
#define kTestDurationSeconds 5.0f
#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 60.0f

@interface CountdownTimerViewController ()

@end

@implementation CountdownTimerViewController
@synthesize testVCDelegate;
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
	secondsRemaining = kTestDurationSeconds;
	[self updateCountdownLabel];
}


- (IBAction)startButtonPressed:(id)sender {
//	if([countdownTimer isValid])
	countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateCountdownLabel) userInfo:nil repeats:YES];
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
		[countdownTimer invalidate];
		[self timerHasFinished];
	}
}

-(void)timerHasFinished
{
	if (testVCDelegate)
		[testVCDelegate timerHasFinished];
}

-(int)calculateScoreForDuration:(int)duration readingTime:(int)readingTime wordsGenerated:(int)wordsGenerated
{
	return (duration - readingTime) / wordsGenerated;
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
