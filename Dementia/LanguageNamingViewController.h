//
//  LanguageNamingViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface LanguageNamingViewController : TestViewController
{
    // memory_keyword, IBThing, Class, pointer name
    __weak IBOutlet UIImageView *inputImageView;
    __weak IBOutlet UIView *controlPanel;
    __weak IBOutlet UIButton *yesButton;
    __weak IBOutlet UIButton *noButton;
    __weak IBOutlet UIButton *confirmButton;
    NSArray *imagesDicts;
    NSDictionary *currentImage;
    BOOL answerWasCorrect;
    int currentScore;
    int currentImageOrder;
}
- (IBAction)decisionButtonPressed:(id)sender;
- (IBAction)confirmButtonPressed:(id)sender;
- (IBAction)showControlsButtonPressed:(id)sender;
-(void)showControlPanel;
-(void)hideControlPanel;
-(NSArray *)getTestImages;
@end
