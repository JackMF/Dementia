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
	[self.test setTestScore:0];
}

-(void)makeControlPanelWithIsDynamic:(BOOL)isDynamic
{
	controlPanelViewController = [[ControlPanelViewController alloc] initWithNibName:@"ControlPanelViewController" bundle:nil];
	[controlPanelViewController setIsDynamic:isDynamic];
	// Add the control panel to the view
	[self addChildViewController:controlPanelViewController];
	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 185.0, 768.0, 185.0);
	[controlPanelViewController.view setFrame:cpFrame];
	[controlPanelViewController setTestVSDelegate:self];
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

-(void)makeMultiControlPanelWithTitles:(NSArray *)titles;
{
	MultiControlPanelViewController *multiControlPanelViewController = [[MultiControlPanelViewController alloc] initWithNibName:@"MultiControlPanelViewController" bundle:nil];
	[multiControlPanelViewController setButtonTitles:titles];
	controlPanelViewController = multiControlPanelViewController;
	[controlPanelViewController setIsDynamic:NO];
	// Add the control panel to the view
	[self addChildViewController:controlPanelViewController];
	CGRect cpFrame = CGRectMake(0.0, 1024.0 - 185.0, 768.0, 185.0);
	[controlPanelViewController.view setFrame:cpFrame];
	[controlPanelViewController setTestVSDelegate:self];
	[self.view addSubview:controlPanelViewController.view];
	[controlPanelViewController didMoveToParentViewController:self];

	[controlPanelViewController performSelectorOnMainThread:@selector(showControlPanel) withObject:nil waitUntilDone:NO];
}

-(BOOL)automaticallyAdjustsScrollViewInsets
{
	return NO;
}

-(void)hasFinished
{
	if (self.test)                  // If we have a test,
		[self.test startPostTest];  // start the post test
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
