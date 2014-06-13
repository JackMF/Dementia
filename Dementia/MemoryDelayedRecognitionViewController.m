//
//  MemoryDelayedRecognitionViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryDelayedRecognitionViewController.h"
#import "Test.h"
#import "MultiControlPanelViewController.h"

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
	questions = [test questions];
}

-(void)viewWillAppear:(BOOL)animated
{
	currentQuestionOrder = 0;
	[super makeMultiControlPanelWithTitles:@[@"True",@"False"] andValues:@[@0,@1]];
	[self loadNextQuestion];
}

-(void)loadNextQuestion
{
	NSArray *nextQuestionArray = [questions objectAtIndex:currentQuestionOrder];
	NSString *nextQuestion = [nextQuestionArray objectAtIndex:0];
	[super animateElementOut:questionLabel andBringBackWithValue:nextQuestion];
	[self updateButtonValues];
	currentQuestionOrder++;
}

-(void)updateButtonValues
{
	NSMutableArray *newButtonValues = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1], nil];
	NSArray *nextQuestionArray = [questions objectAtIndex:currentQuestionOrder];
	NSInteger nextCorrectAnswer = (int) [[nextQuestionArray objectAtIndex:1] integerValue];
	[newButtonValues replaceObjectAtIndex:nextCorrectAnswer withObject:[NSNumber numberWithInt:0]];
	[super updateMultiControlPanelValues:newButtonValues];
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	MultiControlPanelViewController *cp = (MultiControlPanelViewController *)[super controlPanelViewController];
	int score = [cp answerScore];
	[test addToTestScore:score];
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
