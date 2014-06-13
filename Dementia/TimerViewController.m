//
//  TimerViewController.m
//  Dementia
//
//  Created by Chris on 11/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TimerViewController.h"
#import "TestViewController.h"

@interface TimerViewController ()

@end

@implementation TimerViewController
@synthesize testVCDelegate;
int minutes, seconds;
int secondsElapsed;

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
	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
	secondsElapsed = 0;
	[self updateTimerLabel];
}

-(void)updateTimerLabel
{
	NSString *labelText;
	if(secondsElapsed > 0 ) {
		minutes = (secondsElapsed % 3600) / 60;
		seconds = (secondsElapsed %3600) % 60;
		labelText = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
		timerLabel.text = labelText;
		secondsElapsed++;
	} else {
		labelText = @"00:00";
		timerLabel.text = labelText;
		secondsElapsed++;
	}
}

-(void)timerHasFinished
{
	if (testVCDelegate)
		[testVCDelegate timerStoppedWithTimeElapsed:secondsElapsed];
}

- (IBAction)startButtonPressed {
	if (![timer isValid]) {
		timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTimerLabel) userInfo:nil repeats:YES];
	}
}

- (IBAction)stopButtonPressed {
	[timer invalidate];
	timer = nil;
	[self timerHasFinished];
}

-(void)didMoveToParentViewController:(UIViewController *)parent
{
	if (!parent) {
		[timer invalidate];
		timer = nil;
		secondsElapsed = 0;
	}
}
-(void)viewDidDisappear:(BOOL)animated
{
	[timer invalidate];
	timer = nil;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
