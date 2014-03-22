//
//  PostTestViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "PostTestViewController.h"
#import "Test.h"

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
		[titleLabel setText:[test getFullTestName]];
		[textView setText:[test postTestMessage]];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)endButtonPressed {
	[test endTest];
}
@end
