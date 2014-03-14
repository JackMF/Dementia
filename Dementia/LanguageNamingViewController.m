//
//  LanguageNamingViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageNamingViewController.h"

#define kImageViewAnimationDuration 0.2
#define kControlPanelAnimationDuration 0.5

@interface LanguageNamingViewController ()

@end

@implementation LanguageNamingViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Language - Naming";
        score = 0;
        order = 0;        
        NSString *imagesPlistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
        // Load image database from file
        imagesDicts = [NSArray arrayWithContentsOfFile:imagesPlistPath];
        // Sort them by 'order'
        imagesDicts = [imagesDicts sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNextImage];
}

-(void)loadNextImage
{
    if (order < [imagesDicts count]) {
        NSDictionary *imageDict = [imagesDicts objectAtIndex:order];
        UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
        
        CGRect originalFrame = inputImageView.frame;
        CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
        CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);

        [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
            inputImageView.frame = leftFrame;
        }
         completion:^(BOOL finished) {
             // Set the new image
             [inputImageView setImage:newImage];
             // Animate the inputImageView in from the right
             inputImageView.frame = rightFrame;
             [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
                 inputImageView.frame = originalFrame;
             }];
         }];
        // Ensure we load a new image next time
        order++;
    } else {
        [super hasFinished];
    }
}

-(void)showControls
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

-(void)hideControls
{
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

- (IBAction)decisionButtonPressed:(id)sender
{
    [yesButton setBackgroundColor:[UIColor clearColor]];
    [noButton setBackgroundColor:[UIColor clearColor]];
    if (sender==yesButton) {
        isCorrect = YES;
        [yesButton setBackgroundColor:[UIColor redColor]];
    } else if (sender==noButton) {
        isCorrect = NO;
        [noButton setBackgroundColor:[UIColor redColor]];
    }
    [confirmButton setHidden:NO];
}

- (IBAction)confirmButtonPressed:(id)sender {
    // If we're correct, update the score for this test
    if (isCorrect) score++;
    NSLog(@"Score: %i", score);
    
    [yesButton setBackgroundColor:[UIColor clearColor]];
    [noButton setBackgroundColor:[UIColor clearColor]];

    [self loadNextImage];
    [confirmButton setHidden:YES];
    [self hideControls];
    // Load the next image
}

- (IBAction)showControlsButtonPressed:(id)sender {
    [self showControls];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
