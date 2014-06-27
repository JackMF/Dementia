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
#import "PreTestViewController.h"
#import "PostTestViewController.h"
#define kAnimationDuration 0.6f

#define kSpeakingDurationSeconds 60.0f
#define kWritingDurationSeconds 120.0f

#define kBorderSize 6



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
	[self setNavigationItems];
	if ([self isActualTest])
		[test setScore : 0];
}

-(void)setNavigationItems
{
	[self.navigationItem setHidesBackButton:YES];
	UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenuAlert)];
	self.navigationItem.rightBarButtonItem = menuButton;
}

-(void)showMenuAlert
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
	UIActionSheet *leavingTestActionSheet = [[UIActionSheet alloc]
	    initWithTitle:@"Warning - will reset test. Continue?"
	    delegate:self
	    cancelButtonTitle:@"Cancel"
	    destructiveButtonTitle:nil
	    otherButtonTitles:
	    @"Yes",
	    @"No",
	    nil];

	[leavingTestActionSheet showInView:self.view];
}

-(void)leaveTest
{
	[test setHasStarted:NO];
	[test setIsComplete:NO];
	[self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if ([actionSheet.title isEqualToString:@"Menu"]) {
		if (buttonIndex==0) {
			if ([self isActualTest]) [self showLeavingTestAlert];
			else [self leaveTest];
		}
	} else
	if (buttonIndex==0) [self leaveTest];
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
	[self.test startPostTest];
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


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(BOOL)isActualTest
{
	return (![self isKindOfClass:[PreTestViewController class]] && ![self isKindOfClass:[PostTestViewController class]]);
}

-(UIView *)getBorderViewForButton:(UIButton *)button;
{
	CGRect borderFrame = CGRectMake(button.frame.origin.x-kBorderSize, button.frame.origin.y-kBorderSize, button.frame.size.width + (kBorderSize*2), button.frame.size.height + (kBorderSize*2));
	UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];
	UIColor *selectedColor = [UIColor colorWithRed:0.000 green:0.463 blue:1.000 alpha:0.7f];

	if (button.selected)
		[borderView setBackgroundColor:selectedColor];
	else
		[borderView setBackgroundColor:[UIColor whiteColor]];
	return borderView;
}


@end
