//
//  LanguageComprehensionViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageComprehensionViewController.h"
#import "Test.h"
#define kImageViewAnimationDuration 0.6
#define kBorderSize 5

@interface LanguageComprehensionViewController ()

@end

@implementation LanguageComprehensionViewController
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
	currentQuestionOrder = 0;
	//[self loadNextQuestion];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	isSelected = NO;
	currentButtonSelected = nil;

	[nextQuesiton setHidden:YES];

	self.title = [test getFullTestName];
	imagesDicts = [test imageDictionaries];

	for (NSDictionary *imageDict in imagesDicts) {
		UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
		[newImage setAccessibilityIdentifier:[imageDict valueForKey:@"filename"]];
		int tag = (int)[[imageDict valueForKey:@"order"] integerValue]+1;
		UIButton *button = (UIButton *)[self.view viewWithTag:tag];
		[button setImage:newImage forState:UIControlStateNormal];
	}

	questionDicts = [test questions];     //Loading the quesitons
	[questionLabel setText:[[questionDicts objectAtIndex:currentQuestionOrder] valueForKey:@"question"]];
	correctAnswer = [[questionDicts objectAtIndex: currentQuestionOrder] valueForKey:@"correctFileName"];

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)imageButtonPressed:(id)sender {


	UIButton* button = (UIButton*)sender;
	NSString* nameOfButton = [[button currentImage] accessibilityIdentifier];
	UIImage *buttonImage = [button imageForState:UIControlStateNormal];

	for (NSDictionary *imageDict in imagesDicts) {
		UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
		if (buttonImage == newImage) {
//            currentButtonSelected = [imageDict valueForKey:@"filename"];
		}
	}

	if (!isSelected) {     //case when nothing is selected
		button.selected = YES;
		currentButtonSelected = nameOfButton;
		isSelected = YES;
		[nextQuesiton setHidden:NO];
		NSLog(@"Current Image Selected1: %@", currentButtonSelected);
	}
	else if(isSelected && currentButtonSelected == nameOfButton) {     //case when the current button is selcted
		button.selected = NO;
		isSelected = NO;
		currentButtonSelected = nil;
		[nextQuesiton setHidden:YES];
		NSLog(@"Current Image Selected2: %@", currentButtonSelected);


	}
	else{
		button.selected = YES;
		isSelected = YES;
		[nextQuesiton setHidden:NO];

		currentButtonSelected = nameOfButton;
		NSLog(@"Current Image Selected3: %@", currentButtonSelected);
		for (id object in [self.view subviews]) {
			if ([object isKindOfClass:[UIButton class]]) {
				UIButton *button2 = (UIButton *) object;
				if (button2 != button) {
					button2.selected = NO;

					CGRect buttonFrame = button2.frame;
					CGRect borderFrame = CGRectMake(buttonFrame.origin.x-kBorderSize, buttonFrame.origin.y - kBorderSize, buttonFrame.size.width + (kBorderSize*2), buttonFrame.size.height + (kBorderSize*2));

					UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];
					[borderView setBackgroundColor:[UIColor whiteColor]];
					[self.view insertSubview:borderView belowSubview:button2];

				}


			}
		}

	}


	CGRect buttonFrame = button.frame;
	CGRect borderFrame = CGRectMake(buttonFrame.origin.x-kBorderSize, buttonFrame.origin.y-kBorderSize, buttonFrame.size.width + (kBorderSize*2), buttonFrame.size.height + (kBorderSize*2));

	UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];

	if (button.selected) [borderView setBackgroundColor:[UIColor blackColor]];
	else [borderView setBackgroundColor:[UIColor whiteColor]];
	[self.view insertSubview:borderView belowSubview:button];
}

-(void)loadNextQuestion {
	NSDictionary *questionDict = [questionDicts objectAtIndex:currentQuestionOrder];
	NSString *newQuestion = [questionDict valueForKey:@"question"];
	CGRect originalFrame = questionLabel.frame;
	CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
	CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);

	// Animate and swap questions
	[UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
	    questionLabel.frame = leftFrame;     // Animate the image view off to the left
	} completion:^(BOOL finished) {         // Once animation is finished
	    [questionLabel setText:newQuestion];     // Set the new image
	    questionLabel.frame = rightFrame;     // Move the inputImageView the right
	    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {     // Once animation is finished
	        questionLabel.frame = originalFrame;     // Animate the inputImageView in from the right
		}];
	}];

	//Unselect current selected image.
	isSelected = NO;
	currentButtonSelected = nil;

	for (id object in [self.view subviews]) {
		if ([object isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *) object;
			if (button.selected) {
				CGRect buttonFrame = button.frame;
				CGRect borderFrame = CGRectMake(buttonFrame.origin.x-kBorderSize, buttonFrame.origin.y-kBorderSize, buttonFrame.size.width + (kBorderSize*2), buttonFrame.size.height + (kBorderSize*2));
				UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];
				[borderView setBackgroundColor:[UIColor whiteColor]];
				[self.view insertSubview:borderView belowSubview:button];
			}
		}
	}

	correctAnswer = [[questionDicts objectAtIndex: currentQuestionOrder] valueForKey:@"correctFileName"];     //Getting the correct answer for the next questions
}

- (IBAction)nextButtonPressed:(id)sender {

	if (correctAnswer == currentButtonSelected) {
		[test addToTestScore:1];
	}
	currentQuestionOrder++;
	if (currentQuestionOrder < [questionDicts count]) {
		//check if there are more question
		[nextQuesiton setHidden:YES];
		[self loadNextQuestion];
	}
	else
		[super hasFinished];
}
@end