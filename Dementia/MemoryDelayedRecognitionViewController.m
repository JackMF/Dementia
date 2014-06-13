//
//  MemoryDelayedRecognitionViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryDelayedRecognitionViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"

@interface MemoryDelayedRecognitionViewController ()

@end

@implementation MemoryDelayedRecognitionViewController
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
	// Do any additional setup after loading the view from its nib.
	questions = [[super test] questions];
	[super makeStaticControlPanel];
}

-(void)viewWillAppear:(BOOL)animated
{
	currentQuestionOrder = 0;
	[self loadNextQuestion];
}

-(void)loadNextQuestion
{
	NSArray *nextQuestionArray = [questions objectAtIndex:currentQuestionOrder];
	NSString *nextQuestion = [nextQuestionArray objectAtIndex:0];

	[super animateElementOut:questionLabel andBringBackWithValue:nextQuestion];
	currentQuestionOrder++;
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	if (currentQuestionOrder < [questions count])     // If there's still images left
		[self loadNextQuestion];               // Load the next image
	else [super hasFinished];     // Otherwise tell the Test we've finished, and our score
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
