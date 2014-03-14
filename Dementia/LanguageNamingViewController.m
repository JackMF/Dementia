//
//  LanguageNamingViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageNamingViewController.h"
#import "ImageLoader.h"

#define kImageViewAnimationDuration 0.3
#define kControlPanelAnimationDuration 0.2

@interface LanguageNamingViewController ()

@end

@implementation LanguageNamingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Language - Naming";
        imagesDicts = [[ImageLoader sharedInstance] getTestImages]; // Load images for the test
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    currentScore = 0;       // Reset the current score
    currentImageOrder = 0;  // Reset the current image we're showing
    [self loadNextImage];   // Load the next (i.e first) image
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

    // Animage and swap images
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

// Handles logic if we push the yes or no button
- (IBAction)decisionButtonPressed:(id)sender
{
    answerWasCorrect = (sender==yesButton); // Correct if the tester pushed the Yes button
    if (answerWasCorrect) [yesButton setBackgroundColor:[UIColor redColor]];    // If we were right, highlight the yes button
    else [noButton setBackgroundColor:[UIColor redColor]];          // If we were wrong, highlight the no button
    [confirmButton setHidden:NO];           // Show the confirm button
}

// Handle presses of the confirm button
- (IBAction)confirmButtonPressed:(id)sender {
    if (answerWasCorrect) currentScore++;   // If we're correct, update the score for this test
    NSLog(@"Score: %i", currentScore);      // Log the new score
    currentImageOrder++;                    // Increment our  image order
    [confirmButton setHidden:YES];          // Hide the confirm button
    [self hideControlPanel];                    // Hide the control panel
    if (currentImageOrder < [imagesDicts count])  // If there's still images left
        [self loadNextImage];               // Load the next image
    else [super hasFinishedTestWithScore:currentScore];  // Otherwise tell the Test we've finished, and our score
}

// Triggered when the invisible button at the bottom of the screen is pressed
- (IBAction)showControlsButtonPressed:(id)sender {
    [self showControlPanel];
}

// Show the control panel at the bottom of the screen
-(void)showControlPanel
{
    CGRect currentFrame = controlPanel.frame;
    double newY = currentFrame.origin.y - currentFrame.size.height;
    CGRect newFrame = CGRectMake(currentFrame.origin.x, newY, currentFrame.size.width, currentFrame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kControlPanelAnimationDuration];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    controlPanel.frame = newFrame;
    [UIView commitAnimations];
}
// Hide the control panel at the bottom of the screen
-(void)hideControlPanel
{
    [self resetDecisionButtons];    // First reset the appearance of the buttons
    CGRect currentFrame = controlPanel.frame;
    double newY = currentFrame.origin.y + currentFrame.size.height;
    CGRect newFrame = CGRectMake(currentFrame.origin.x, newY, currentFrame.size.width, currentFrame.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kControlPanelAnimationDuration];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    controlPanel.frame = newFrame;
    [UIView commitAnimations];
}

// Resets the decision buttons to their original state
-(void)resetDecisionButtons
{
    [yesButton setBackgroundColor:[UIColor clearColor]];
    [noButton setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
