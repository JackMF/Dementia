//
//  ControlPanelViewController.m
//  Dementia
//
//  Created by Chris on 16/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ControlPanelViewController.h"
#import "TestViewController.h"
#define kControlPanelAnimationDuration 0.2

@interface ControlPanelViewController ()

@end

@implementation ControlPanelViewController
@synthesize testVSDelegate;
@synthesize isDisplayed;
@synthesize answerWasCorrect;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		isDisplayed = NO;
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}


// Handle presses of the confirm button
- (IBAction)confirmButtonPressed:(id)sender {
	[testVSDelegate didConfirmAnswer];      // Tell our test view controller we have an answer
	[confirmButton setHidden:YES];          // Hide the confirm button
	[self hideControlPanel];       // Hide the control panel
}

// Show the control panel at the bottom of the screen
-(void)showControlPanel
{
	CGRect currentFrame = controlPanelView.frame;
	double newY = currentFrame.origin.y - currentFrame.size.height;
	CGRect newFrame = CGRectMake(currentFrame.origin.x, newY, currentFrame.size.width, currentFrame.size.height);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kControlPanelAnimationDuration];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	controlPanelView.frame = newFrame;
	[UIView commitAnimations];
	isDisplayed = YES;
}
// Hide the control panel at the bottom of the screen
-(void)hideControlPanel
{
	[confirmButton setHidden:YES];
	[self resetDecisionButtons];    // First reset the appearance of the buttons
	CGRect currentFrame = controlPanelView.frame;
	double newY = currentFrame.origin.y + currentFrame.size.height;
	CGRect newFrame = CGRectMake(currentFrame.origin.x, newY, currentFrame.size.width, currentFrame.size.height);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:kControlPanelAnimationDuration];
	[UIView setAnimationDelay:0.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	controlPanelView.frame = newFrame;
	[UIView commitAnimations];
	isDisplayed = NO;
}

// Handles logic if we push the yes or no button
- (IBAction)decisionButtonPressed:(id)sender
{
	[self resetDecisionButtons];
	answerWasCorrect = (sender==yesButton); // Correct if the tester pushed the Yes button
	[(UIButton *)sender setBackgroundColor :[UIColor redColor]];
	[confirmButton setHidden:NO];           // Show the confirm button
}

// Resets the decision buttons to their original state
-(void)resetDecisionButtons
{
	[yesButton setBackgroundColor:[UIColor clearColor]];
	[noButton setBackgroundColor:[UIColor clearColor]];
}

// Triggered when the invisible button at the bottom of the screen is pressed
- (void)toggleControlPanel
{
	if ([self isDisplayed])
		[self hideControlPanel];
	else
		[self showControlPanel];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
