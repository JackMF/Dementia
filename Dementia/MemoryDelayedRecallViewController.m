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
#import "TestManager.h"

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
	testManager = [TestManager sharedInstance];
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
	[buttonListViewController setButtonValues:buttonLabelValues];

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
	int correct = (int) [buttonListViewController getNumberOfCorrectAnswers];
	int recallScore = (int) [(Test *)[[testManager tests] objectAtIndex:2] score];
	double percentRetained = [self getPercentRetainedFromRecallScore:recallScore delayedRecallScore:correct];
	int score = [self getScoreFromPercentageRetined:percentRetained];
	[test addToTestScore:score];
	[super hasFinished];
}


-(double)getPercentRetainedFromRecallScore:(int)recallScore delayedRecallScore:(int)delayedRecallScore
{
	if (recallScore && delayedRecallScore)
		return delayedRecallScore / (float)recallScore;
	return 0.0;
}

-(int)getScoreFromPercentageRetined:(double)percentageRetained
{
	if (percentageRetained == 0.0) return 0;
	else if (percentageRetained <= 0.1) return 1;
	else if (percentageRetained <= 0.2) return 2;
	else if (percentageRetained <= 0.3) return 3;
	else if (percentageRetained <= 0.4) return 4;
	else if (percentageRetained <= 0.5) return 5;
	else if (percentageRetained <= 0.6) return 6;
	else if (percentageRetained <= 0.7) return 7;
	else if (percentageRetained <= 0.8) return 8;
	else if (percentageRetained <= 0.9) return 9;
	else if (percentageRetained > 0.9) return 10;
	return 0;
}
@end
