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
#define kImageViewAnimationDuration 0.6

@interface LanguageSpellingViewController ()

@end

@implementation LanguageSpellingViewController
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
    wordOrder = 0;
    toSpellArray = [test toSpell];
    [super makeDynamicControlPanel];
   // [super showContolPanel];
    [self loadNextWord];
    
    
  
    

    
    

    
     
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)loadNextWord{
    
    
    
    NSString *newWord = [toSpellArray objectAtIndex:wordOrder];
    
	CGRect originalFrame = toSpellLabel.frame;
	CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
	CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    
	// Animate and swap questions
	[UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
	    toSpellLabel.frame = leftFrame;     // Animate the image view off to the left
	} completion:^(BOOL finished) {         // Once animation is finished
	    [toSpellLabel setText:newWord];     // Set the new image
	    toSpellLabel.frame = rightFrame;     // Move the inputImageView the right
	    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {     // Once animation is finished
	        toSpellLabel.frame = originalFrame;     // Animate the inputImageView in from the right
		}];
	}];

    
}



- (void)didConfirmAnswer
{
	if ([[super controlPanelViewController] answerWasCorrect])
		[test addToTestScore:1];            // If we're correct, update the score for this test
	wordOrder++;                    // Increment our  image order
	if (wordOrder < [toSpellArray count])  // If there's still images left
		[self loadNextWord];               // Load the next image
	else [super hasFinished];  // Otherwise tell the Test we've finished, and our score
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
