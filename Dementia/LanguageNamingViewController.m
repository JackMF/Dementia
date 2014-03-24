//
//  LanguageNamingViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageNamingViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"

#define kImageViewAnimationDuration 0.3

@interface LanguageNamingViewController ()

@end

@implementation LanguageNamingViewController
@synthesize test;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
	}
	return self;
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	currentImageOrder = 0;  // Reset the current image we're showing
	[self loadNextImage];   // Load the next (i.e first) image
	[super makeDynamicControlPanel];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	imagesDicts = [test imageDictionaries]; // Load the images for this test
}

// Loads the next image, handles animation
-(void)loadNextImage
{
	// Grab the new image
	NSDictionary *imageDict = [imagesDicts objectAtIndex:currentImageOrder];
	UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];

	// Work out where things are, and where they should go
	CGRect originalFrame = inputImageView.frame;
	CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
	CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);

	// Animate and swap images
	[UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
	    inputImageView.frame = leftFrame;   // Animate the image view off to the left
	} completion:^(BOOL finished) {         // Once animation is finished
	    [inputImageView setImage:newImage]; // Set the new image
	    inputImageView.frame = rightFrame; // Move the inputImageView the right
	    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {    // Once animation is finished
	        inputImageView.frame = originalFrame; // Animate the inputImageView in from the right
		}];
	}];
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	currentImageOrder++;                    // Increment our  image order
	if (currentImageOrder < [imagesDicts count])  // If there's still images left
		[self loadNextImage];               // Load the next image
	else [super hasFinished];  // Otherwise tell the Test we've finished, and our score
}



- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
