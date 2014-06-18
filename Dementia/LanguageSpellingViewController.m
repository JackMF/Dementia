//
//  LanguageSpellingViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 22/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageSpellingViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"
#define kImageViewAnimationDuration 0.6f

@interface LanguageSpellingViewController ()

@end

@implementation LanguageSpellingViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[super makeStaticControlPanel];
	[toSpellLabel setText:nil];
	wordOrder = 0;
	toSpellArray = [test questions];
	[self loadNextWord];
}

-(void)loadNextWord {
	NSString *newWord = [toSpellArray objectAtIndex:wordOrder];
	[super animateElementOut:toSpellLabel andBringBackWithValue:newWord];
	wordOrder++;                    // Increment our  image order
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	if (wordOrder < [toSpellArray count])     // If there's still images left
		[self loadNextWord];               // Load the next image
	else [super hasFinished];     // Otherwise tell the Test we've finished, and our score
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
