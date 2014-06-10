//
//  LanguageComprehensionViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageComprehensionViewController.h"
#import "Test.h"
#define kImageViewAnimationDuration 0.6f
#define kBorderSize 5

@interface LanguageComprehensionViewController ()

@end

@implementation LanguageComprehensionViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		questionDicts = [NSArray new];
		imagesDicts = [NSArray new];
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	currentQuestionOrder = 0;
	currentlySelectedButton.selected = NO;
	currentlySelectedButton = nil;
	[self resetButtons];
	[self loadCurrentQuestion];
}

-(void)loadCurrentQuestion
{
	[questionLabel setText:[[questionDicts objectAtIndex:currentQuestionOrder] valueForKey:@"question"]];
	correctAnswer = [[questionDicts objectAtIndex: currentQuestionOrder] valueForKey:@"correctFileName"];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	questionDicts = [test questions];     //Loading the quesitons
	imagesDicts = [test imageDictionaries];
	[self displayButtonImages];
	questionCenter = questionLabel.center;
}

-(void)displayButtonImages
{
	for (NSDictionary *imageDict in imagesDicts) {
		// Load the image
		NSString *imageFilename =[imageDict valueForKey:@"filename"];
		UIImage *newImage = [UIImage imageNamed:imageFilename];

		// Find the correct button
		int tag = (int)[[imageDict valueForKey:@"order"] integerValue]+1;
		UIButton *button = (UIButton *)[self.view viewWithTag:tag];

		[button setImage:newImage forState:UIControlStateNormal];       // Set the image
		[[button imageView] setContentMode: UIViewContentModeScaleAspectFit]; // Ensure the image scales properly
		// Ensure the whole background is white when selected
		[[button imageView] setBackgroundColor:[UIColor whiteColor]];
		[button setAdjustsImageWhenHighlighted:NO];
	}
}

- (IBAction)imageButtonPressed:(id)sender {
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

-(NSString *)getFilenameForButton:(UIButton *)button
{
	for (NSDictionary *imageDict in imagesDicts) {
		int tag = (int)[[imageDict valueForKey:@"order"] integerValue]+1;
		if (tag == button.tag)
			return [imageDict valueForKey:@"filename"];
	}
	return nil;
}

-(void)loadNextQuestion {
	NSDictionary *questionDict = [questionDicts objectAtIndex:currentQuestionOrder];
	// Load the correct answer for the next question
	correctAnswer = [[questionDicts objectAtIndex: currentQuestionOrder] valueForKey:@"correctFileName"];

	NSString *newQuestion = [questionDict valueForKey:@"question"];
	[self swapQuestion:newQuestion];

}

-(void)swapQuestion:(NSString *)newQuestion
{
	// Animate and swap questions
	[self animateQuestionOutAndChangeValue:newQuestion];
}

-(void)animateQuestionOutAndChangeValue:(NSString *)newValue
{
	[UIView animateWithDuration:kImageViewAnimationDuration
	animations:^{
	    questionLabel.alpha = 0.0f;
	} completion:^(BOOL finished) {
	    [questionLabel setText:newValue];
	    //Unselect current selected image.
	    currentlySelectedButton.selected = NO;
	    currentlySelectedButton = nil;
	    [self resetButtons];

	    [self animateQuestionIn];
	}];
}

-(void)animateQuestionIn
{
	[UIView animateWithDuration:kImageViewAnimationDuration
	animations:^() {
	    questionLabel.alpha = 100.0f;
	}];
}

- (IBAction)nextButtonPressed:(id)sender {
	if (correctAnswer == [self getFilenameForButton:currentlySelectedButton])
		[test addToTestScore:1];

	currentQuestionOrder++;
	if (currentQuestionOrder < [questionDicts count]) {
		//check if there are more question
		[self loadNextQuestion];
	} else
		[super hasFinished];
}

-(void)resetButtons
{
	for (id object in [self.view subviews]) {
		if ([object isKindOfClass:[UIButton class]])
			[self configureBorderForButton:(UIButton *)object];
	}
	BOOL readyForNextQuestion = (currentQuestionOrder < [questionDicts count] && currentlySelectedButton!=nil);
	[nextQuestionButton setHidden:!readyForNextQuestion];
}

-(void)configureBorderForButton:(UIButton *)button
{
	CGRect borderFrame = CGRectMake(button.frame.origin.x-kBorderSize, button.frame.origin.y-kBorderSize, button.frame.size.width + (kBorderSize*2), button.frame.size.height + (kBorderSize*2));
	UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];

	if (button.selected)
		[borderView setBackgroundColor:[UIColor grayColor]];
	else
		[borderView setBackgroundColor:[UIColor whiteColor]];

	[self.view insertSubview:borderView belowSubview:button];
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end