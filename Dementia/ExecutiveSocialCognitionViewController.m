//
//  SocialCognitionPartAViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExecutiveSocialCognitionViewController.h"
#import "Test.h"
#define kImageViewAnimationDuration 0.2

@interface ExecutiveSocialCognitionViewController ()

@end

@implementation ExecutiveSocialCognitionViewController
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
}

-(void)viewWillAppear:(BOOL)animated
{
	for (UIButton *button in @[answer0Button, answer1Button, answer2Button, answer3Button]) {
		[button setImage:nil forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor whiteColor]];
		[button setShowsTouchWhenHighlighted:NO];
		[button setAdjustsImageWhenHighlighted:NO];
		[button.imageView setContentMode:UIViewContentModeScaleAspectFit];
	}
	currentlySelectedButton.selected = NO;
	currentlySelectedButton = nil;
	currentQuestionOrder = 0;
	currentStageOrder = 0;
	[faceImageView setImage:nil];
	[self loadNextQuestion];
}

-(void)populateQuestionView
{
	questions = [test questions];
	NSArray *currentQuestions = [questions objectAtIndex:currentQuestionOrder];

	UIImage *image0 = [UIImage imageNamed:[currentQuestions objectAtIndex:0]];
	[answer0Button setImage:image0 forState:UIControlStateNormal];
	UIImage *image1 = [UIImage imageNamed:[currentQuestions objectAtIndex:1]];
	[answer1Button setImage:image1 forState:UIControlStateNormal];
	UIImage *image2 = [UIImage imageNamed:[currentQuestions objectAtIndex:2]];
	[answer2Button setImage:image2 forState:UIControlStateNormal];
	UIImage *image3 = [UIImage imageNamed:[currentQuestions objectAtIndex:3]];
	[answer3Button setImage:image3 forState:UIControlStateNormal];

	if (currentStageOrder==1) {
		int fileNum = (int) [(NSNumber *)[currentQuestions objectAtIndex:4] integerValue];
		NSString *smileFilename = [NSString stringWithFormat:@"face%i.jpg", fileNum];
		UIImage *face = [UIImage imageNamed:smileFilename];
		[faceImageView setImage:face];
	}
}

-(void)loadNextQuestion {
	// Animate and swap questions
	[UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
	    questionView.alpha = 0.0f;     // Animate the image view off to the left
	} completion:^(BOOL finished) {         // Once animation is finished
	    currentlySelectedButton.selected = NO;
	    currentlySelectedButton = nil;
	    [self resetButtons];
	    [self populateQuestionView];
	    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {     // Once animation is finished
	        questionView.alpha = 1.0f;
	        currentQuestionOrder++;                    // Increment our  image order
		}];
	}];
}

-(int)getIndexForSender:(id)sender {
	if (sender==answer0Button)
		return 0;
	else if (sender==answer1Button)
		return 1;
	else if (sender==answer2Button)
		return 2;
	else if (sender==answer3Button)
		return 3;
	return -1;
}

- (IBAction)answerButtonPressed:(id)sender {

	UIButton *pressedButton = (UIButton *)sender;

	// Case when nothing is currently selected
	if (!currentlySelectedButton) {
		pressedButton.selected = YES;
		currentlySelectedButton = pressedButton;
		// Case when the tapped button was already selected
	} else if(currentlySelectedButton && currentlySelectedButton == pressedButton) {
		currentlySelectedButton.selected = NO;
		currentlySelectedButton = nil;
		// Case when tapping a diferent button from the currently selected one
	} else if(currentlySelectedButton && currentlySelectedButton != pressedButton) {
		currentlySelectedButton.selected = NO;
		pressedButton.selected = YES;
		currentlySelectedButton = pressedButton;
	}
	[self resetButtons];
}

-(void)resetButtons
{
	for (UIButton *button in @[answer0Button, answer1Button, answer2Button, answer3Button]) {
		UIView *borderView = [self getBorderViewForButton:button];
		[questionView insertSubview:borderView belowSubview:button];
	}
	BOOL readyForNextQuestion = (currentlySelectedButton==nil);
	[nextQuestionButton setHidden:readyForNextQuestion];
}

- (IBAction)nextButtonPressed {
	[nextQuestionButton setHidden:YES];
	int userAnswer = [self getIndexForSender:currentlySelectedButton];
	if (currentStageOrder==0) {
		// Store the user's answer (favorite)
		[userAnswers insertObject:[NSNumber numberWithInt:userAnswer] atIndex:currentQuestionOrder];

		if (currentQuestionOrder < [questions count])     // If there's still images left
			[self loadNextQuestion];               // Load the next image
		else {
			currentQuestionOrder = 0;
			currentStageOrder = 1;
			[self loadNextQuestion];
		}
	} else if (currentStageOrder==1) {
		int score = 0;
		NSArray *currentQuestions = [questions objectAtIndex:currentQuestionOrder-1];
		int correctAnswer = (int) [(NSNumber *)[currentQuestions objectAtIndex:4] integerValue];
		// If the user chose the correct answer
		if (userAnswer == correctAnswer) {
			score = 2;
			// If the user chose their own favorite, they get no marks
		} else if ((int)[userAnswers objectAtIndex:currentQuestionOrder] == userAnswer) {
			score = 0;
			// Otherwise, 1 mark
		} else {
			score = 1;
		}
		[test addToTestScore:score];
		if (currentQuestionOrder < [questions count])         // If there's still images left
			[self loadNextQuestion];                   // Load the next image
		else {
			[super hasFinished];
		}

	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
