//
//  LanguageComprehensionViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageComprehensionViewController.h"
#import "Test.h"
#define kImageViewAnimationDuration 0.3

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

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    currentScore = 0;
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
        int tag = [[imageDict valueForKey:@"order"] integerValue]+1;
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:newImage forState:UIControlStateNormal];
     }
    
    questionDicts = [test questions]; //Loading the quesitons
    [questionLabel setText:[[questionDicts objectAtIndex:currentQuestionOrder] valueForKey:@"question"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButtonPressed:(id)sender {
    UIButton* button = (UIButton*)sender;
    
    if (isSelected && !button.selected) {

        
    }
    else{
        button.selected = !button.selected;
        isSelected = !isSelected;
        if (isSelected){
            
            currentButtonSelected = [[button currentImage] accessibilityIdentifier];
            
            NSLog(@"Current Image Selected: %@", currentButtonSelected);
            [nextQuesiton setHidden:NO];
            
        }
        else{
            [nextQuesiton setHidden:YES];
            currentButtonSelected = nil;
            NSLog(@"Current Image Selected: %@", currentButtonSelected);
        }
    }
    
    
    CGRect buttonFrame = button.frame;
    double borderSize = 10;
    CGRect borderFrame = CGRectMake(buttonFrame.origin.x-borderSize, buttonFrame.origin.y-borderSize, buttonFrame.size.width + (borderSize*2), buttonFrame.size.height + (borderSize*2));
        
    UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];
    if (button.selected){
        [borderView setBackgroundColor:[UIColor greenColor]];
        
        
    }
    else {
        [borderView setBackgroundColor:[UIColor whiteColor]];
        
    }
    [self.view insertSubview:borderView belowSubview:button];
        
    
    
}

-(void)loadNextQuestion{
    

    NSDictionary *questionDict = [questionDicts objectAtIndex:currentQuestionOrder];
    NSString *newQuestion = [questionDict valueForKey:@"question"];
    CGRect originalFrame = questionLabel.frame;
    CGRect leftFrame = CGRectMake(0-originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    CGRect rightFrame = CGRectMake(self.view.frame.size.width + originalFrame.size.width, originalFrame.origin.y, originalFrame.size.width, originalFrame.size.height);
    
    // Animate and swap images
    [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {
        questionLabel.frame = leftFrame;   // Animate the image view off to the left
    } completion:^(BOOL finished) {         // Once animation is finished
        [questionLabel setText:newQuestion]; // Set the new image
        questionLabel.frame = rightFrame; // Move the inputImageView the right
        [UIView animateWithDuration:kImageViewAnimationDuration animations:^() {    // Once animation is finished
            questionLabel.frame = originalFrame; // Animate the inputImageView in from the right
        }];
    }];

    
    correctAnswer = [[questionDicts objectAtIndex: currentQuestionOrder] valueForKey:@"correctFileName"]; //Getting the correct answer for the next questions
    
    

}

- (IBAction)nextButtonPressed:(id)sender {
   
    if (correctAnswer == currentButtonSelected) {
        currentScore++;
    }
    NSLog(@"Current Score: %i", currentScore);
    currentQuestionOrder++;
    if (currentQuestionOrder < [questionDicts count]){
        //check if there are more question
        [nextQuesiton setHidden:YES];
        [self loadNextQuestion];
        
    }
    else [super hasFinishedTestWithScore:currentScore];
    
    
}
@end
