//
//  PostTestViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "PostTestViewController.h"
#import "Test.h"
#import "TestManager.h"

@interface PostTestViewController ()

@end

@implementation PostTestViewController
@synthesize test;

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
	if (test) {
		// Set my own title
		[textView setText:[test postTestMessage]];
		[textView setFont:[UIFont systemFontOfSize:30]];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)endButtonPressed {
	testManager = [TestManager sharedInstance];
	[testManager endTestAndStartNextWithNavController:self.navigationController];
}
@end
