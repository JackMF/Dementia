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

#define kImageViewAnimationDuration 0.6f

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
	[super makeDynamicControlPanel];
	[imageView setImage:nil];
	currentImageOrder = 0;  // Reset the current image we're showing
	[self loadNextImage];   // Load the next (i.e first) image
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

	// Animate and swap images
//	[self animateImageOutAndChangeValue:newImage];
	[super animateElementOut:imageView andBringBackWithValue:newImage];
}

// Handle presses of the confirm button
- (void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	currentImageOrder++;                    // Increment our  image order
	if (currentImageOrder < [imagesDicts count])  // If there's still images left
		[self loadNextImage];               // Load the next image
	else
		[super hasFinished];  // Otherwise tell the Test we've finished, and our score
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
