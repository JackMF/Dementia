//
//  MemoryDelayedRecallViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryDelayedRecallViewController.h"
#import "Test.h"
#import "ButtonListViewController.h"


@interface MemoryDelayedRecallViewController ()

@end

@implementation MemoryDelayedRecallViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self addButtonListViewController];
}
- (void)viewDidLoad
{
	[super viewDidLoad];
}

-(void)addButtonListViewController
{
	// Do any additional setup after loading the view from its nib.
	buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	// Add the control panel to the view
	[self addChildViewController:buttonListViewController];

	CGRect cpFrame = CGRectMake(150.0, 260.0, 478.0, 680.0);
	[buttonListViewController.view setFrame:cpFrame];

	NSArray *buttonLabelValues = [test buttonNames];
	[buttonListViewController setButtonLabelValues:buttonLabelValues];

	[buttonListViewController setOneItemPerRow:YES];

	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
- (IBAction)finishButtonPressed:(id)sender {
	int corrent = [buttonListViewController getNumberOfCorrectAnswers];
	[test addToTestScore:corrent];
	[super hasFinished];
}
@end
