//
//  VisuospatialDotCountingViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 27/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "VisuospatialDotCountingViewController.h"
#import "TestViewController.h"
#import "Test.h"
#define kImageViewAnimationDuration 0.3

@interface VisuospatialDotCountingViewController ()

@end

@implementation VisuospatialDotCountingViewController
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
    currentImage = 0;
    currentScore = 0;
    [super viewWillAppear:animated];
    images = [test imageDictionaries];
    [self loadNextImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)loadNextImage
{
 	// Grab the new image
	NSDictionary *imageDict = [images objectAtIndex:currentImage];
	UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
    
	// Work out where things are, and where they should go
	CGRect originalFrame = imageViewer.frame;
	CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
	CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    
	// Animate and swap images
	[UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
	    imageViewer.frame = leftFrame;   // Animate the image view off to the left
	} completion:^(BOOL finished) {         // Once animation is finished
	    [imageViewer setImage:newImage]; // Set the new image
	    imageViewer.frame = rightFrame; // Move the inputImageView the right
	    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {    // Once animation is finished
	        imageViewer.frame = originalFrame; // Animate the inputImageView in from the right
		}];
	}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
