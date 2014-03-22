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

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if (![self test]) {
		NSLog(@"NO TEST");
	}
	[self.test setTestScore:0];
	if ([self.test hasControlPanel]) {
		controlPanelViewController = [[ControlPanelViewController alloc] initWithNibName:@"ControlPanelViewController" bundle:nil];
		// Add the control panel to the view
		[self addChildViewController:controlPanelViewController];
		CGRect cpFrame = CGRectMake(0.0, 1024.0 - 185.0, 768.0, 185.0);
		[controlPanelViewController.view setFrame:cpFrame];
		[controlPanelViewController setTestVSDelegate:self];
		[self.view addSubview:controlPanelViewController.view];
		[controlPanelViewController didMoveToParentViewController:self];

		// Add the control event stuff
		UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:controlPanelViewController action:@selector(toggleControlPanel)];
		[self.view addGestureRecognizer:singleFingerTap];
	}
}

-(void)didConfirmAnswer
{

}

-(void)viewDidLoad
{
	[super viewDidLoad];
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
