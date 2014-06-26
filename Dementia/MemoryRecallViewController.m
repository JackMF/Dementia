//
//  MemoryRecallViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryRecallViewController.h"
#import "Test.h"
#import "ButtonListViewController.h"

@interface MemoryRecallViewController ()

@end

@implementation MemoryRecallViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self addButtonListViewController];
	[self setButtonLabelValues];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setStoryText];
}

-(void)addButtonListViewController
{
	// Add the control panel to the view
	buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	[self addChildViewController:buttonListViewController];
	CGRect cpFrame = CGRectMake(150.0, 260.0, 478.0, 680.0);
	[buttonListViewController.view setFrame:cpFrame];
	[buttonListViewController setOneItemPerRow:YES];
	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];
}

-(void)setButtonLabelValues
{
	NSArray *buttonLabelValues = [test buttonNames];
	[buttonListViewController setButtonValues:buttonLabelValues];
}

-(void)setStoryText
{
	[storyTextView setText:[test story]];
	[storyTextView setFont:[UIFont systemFontOfSize:24.0]];
}

- (IBAction)finishButtonPressed:(id)sender {
	int corrent = (int) [buttonListViewController getNumberOfCorrectAnswers];
	[test addToTestScore:corrent];
	[super hasFinished];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
