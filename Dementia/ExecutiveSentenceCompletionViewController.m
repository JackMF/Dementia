//
//  ExecutiveSentenceCompletionViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExecutiveSentenceCompletionViewController.h"
#import "Test.h"
#import "MultiControlPanelViewController.h"
#define kImageViewAnimationDuration 0.6

@interface ExecutiveSentenceCompletionViewController ()

@end

@implementation ExecutiveSentenceCompletionViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	currentQuestionOrder = 0;
	NSArray *cpButtonTitles = [test buttonNames];
	[super makeMultiControlPanelWithTitles:cpButtonTitles andValues:@[@2,@1,@0]];
	[self loadNextWord];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	questions = [test questions];
}

-(void)loadNextWord {
	NSString *newWord = [questions objectAtIndex:currentQuestionOrder];
	[super animateElementOut:toCompleteLabel andBringBackWithValue:newWord];
	currentQuestionOrder++;                    // Increment our  image order
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	MultiControlPanelViewController *cp = (MultiControlPanelViewController *) [super controlPanelViewController];
	[test addToTestScore:[cp answerScore]];            // If we're correct, update the score for this test
	if (currentQuestionOrder < [questions count])     // If there's still images left
		[self loadNextWord];               // Load the next image
	else [super hasFinished];     // Otherwise tell the Test we've finished, and our score
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
