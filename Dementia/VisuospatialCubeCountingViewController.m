
//  VisuospatialCubeCountingViewController.m
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "VisuospatialCubeCountingViewController.h"
#import "TestViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"

@interface VisuospatialCubeCountingViewController ()

@end

@implementation VisuospatialCubeCountingViewController
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
	[super viewWillAppear:animated];
	[super makeStaticControlPanel];
	[imageView setImage:nil];
	currentImageOrder = 0;
	currentScore = 0;
	images = [test questions];
	[self loadNextImage];
}


-(void)loadNextImage
{
	// Grab the new image
	NSString *filename = [images objectAtIndex:currentImageOrder];
	UIImage *newImage = [UIImage imageNamed:filename];
	[super animateElementOut:imageView andBringBackWithValue:newImage];
	currentImageOrder++;
}

-(void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	if (currentImageOrder < [images count])     // If there's still images left
		[self loadNextImage];
	else [super hasFinished];     // Otherwise tell the Test we've finished, and our score

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
