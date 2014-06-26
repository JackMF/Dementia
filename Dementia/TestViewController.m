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
#import "DebugViewController.h"
#import "ButtonListViewController.h"
#define kAnimationDuration 0.6f

#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 120.0f



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
	[self makeMenuButton];
	[self.test setScore:0];
}

-(void)makeMenuButton
{
	[self.navigationItem setHidesBackButton:YES];
	UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
	self.navigationItem.rightBarButtonItem = menuButton;
}

-(void)showMenu
{
	UIActionSheet *menuActionSheet = [[UIActionSheet alloc]
	    initWithTitle:@"Menu"
	    delegate:self
	    cancelButtonTitle:@"Cancel"
	    destructiveButtonTitle:nil
	    otherButtonTitles:
	    @"Exit Current Test",
	    @"Cancel",
	    nil];
	[menuActionSheet showInView:self.view];
}

-(void)showLeavingTestAlert
{
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex==0) {
		[self showLeavingTestAlert];
	} else {
	}
}

-(void)showDebugViewController
{
	DebugViewController *debugViewController = [[DebugViewController alloc] initWithNibName:@"DebugViewController" bundle:nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:debugViewController];
	[self presentViewController:navController animated:YES completion:nil];
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
	else if ([element isKindOfClass:[ButtonListViewController class]])
		[self animateButtonListOut:element andBringBackWithValue:newValue];
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

-(void)animateButtonListOut:(ButtonListViewController *)buttonList andBringBackWithValue:(NSArray *)newValues
{
	// Animate and swap questions
	[UIView animateWithDuration:kAnimationDuration animations:^() {
	    [buttonList.view setAlpha:0.0f];
	} completion:^(BOOL finished) {
	    [buttonList setButtonValues:newValues];
	    [UIView animateWithDuration:kAnimationDuration
	    animations:^() {
	        [buttonList.view setAlpha:1.0f];
		}];
	}];

}

-(double)getVFIFromNumberOfWordsProduced:(int)numWordsProduced duration:(int)duration repeatDuration:(int)repeatDuration
{
	if (numWordsProduced && duration && repeatDuration)
		return (duration - repeatDuration) / (double)numWordsProduced;
	return -1.0;
}

-(int)getScoreFromVFI:(double)vfi andDuration:(int)duration
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


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
