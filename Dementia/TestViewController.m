//
//  TestViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"
#import "MultiControlPanelViewController.h"
#define kAnimationDuration 0.6f


@interface TestViewController ()
@end

@implementation TestViewController
@synthesize test;
@synthesize controlPanelViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		controlPanelViewController = nil;
	}
	return self;
}

-(void)viewDidLoad
{
	[super viewDidLoad];
	self.title = [test getFullTestName];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self.test setScore:0];
}

-(void)makeControlPanelWithIsDynamic:(BOOL)isDynamic
{
	controlPanelViewController = [[ControlPanelViewController alloc] initWithNibName:@"ControlPanelViewController" bundle:nil];
	[controlPanelViewController setIsDynamic:isDynamic];
	// Add the control panel to the view
	[self addChildViewController:controlPanelViewController];
	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 185.0, 768.0, 185.0);
	[controlPanelViewController.view setFrame:cpFrame];
	[controlPanelViewController setTestVCDelegate:self];
	[self.view addSubview:controlPanelViewController.view];
	[controlPanelViewController didMoveToParentViewController:self];
}

-(void)makeStaticControlPanel {
	[self makeControlPanelWithIsDynamic:NO];
	[controlPanelViewController performSelectorOnMainThread:@selector(showControlPanel) withObject:nil waitUntilDone:NO];
}
-(void)makeDynamicControlPanel {
	[self makeControlPanelWithIsDynamic:YES];
	// Add gesture recognizer
	UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:controlPanelViewController action:@selector(toggleControlPanel)];
	[self.view addGestureRecognizer:singleFingerTap];
}

-(void)didConfirmAnswer
{
}

-(void)makeMultiControlPanelWithTitles:(NSArray *)titles andValues:(NSArray *)values
{
	MultiControlPanelViewController *multiControlPanelViewController = [[MultiControlPanelViewController alloc] initWithNibName:@"MultiControlPanelViewController" bundle:nil];
	[multiControlPanelViewController setButtonTitles:titles andValues:values];
	controlPanelViewController = multiControlPanelViewController;
	[controlPanelViewController setIsDynamic:NO];
	// Add the control panel to the view
	[self addChildViewController:controlPanelViewController];
	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 185.0, 768.0, 185.0);
	[controlPanelViewController.view setFrame:cpFrame];
	[controlPanelViewController setTestVCDelegate:self];
	[self.view addSubview:controlPanelViewController.view];
	[controlPanelViewController didMoveToParentViewController:self];

	[controlPanelViewController performSelectorOnMainThread:@selector(showControlPanel) withObject:nil waitUntilDone:NO];
}

-(void)updateMultiControlPanelValues:(NSArray *)newValues
{
	[(MultiControlPanelViewController *)controlPanelViewController updateButtonValues : newValues];
}

-(BOOL)automaticallyAdjustsScrollViewInsets
{
	return NO;
}

-(void)hasFinished
{
	[self.test setIsComplete:YES];
	if (self.test)                  // If we have a test,
		[self.test startPostTest];  // start the post test
}

-(void)countdownTimerHasFinished
{

}

-(void)timerStoppedWithTimeElapsed:(int)timeElapsed
{

}

-(void)animateElementOut:(id)element andBringBackWithValue:(id)newValue
{
	if ([element isKindOfClass:[UILabel class]])
		[self animateLabelOut:element andBringBackWithValue:newValue];
	else if ([element isKindOfClass:[UIImageView class]])
		[self animateImageViewOut:element andBringBackWithValue:newValue];
}

-(void)animateLabelOut:(UILabel *)label andBringBackWithValue:(NSString *)newValue
{
	// Animate and swap questions
	[UIView animateWithDuration:kAnimationDuration animations:^() {
	    [label setAlpha:0.0f];
	} completion:^(BOOL finished) {
	    [label setText:newValue];
	    [UIView animateWithDuration:kAnimationDuration
	    animations:^() {
	        [label setAlpha:1.0f];
		}];
	}];

}

-(void)animateImageViewOut:(UIImageView *)imageView andBringBackWithValue:(UIImage *)newValue
{
	// Animate and swap questions
	[UIView animateWithDuration:kAnimationDuration animations:^() {
	    [imageView setAlpha:0.0f];
	} completion:^(BOOL finished) {
	    [imageView setImage:newValue];
	    [UIView animateWithDuration:kAnimationDuration
	    animations:^() {
	        [imageView setAlpha:1.0f];
		}];
	}];

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
