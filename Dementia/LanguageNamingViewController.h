//
//  LanguageNamingViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageNamingViewController : UIViewController
{
    // memory_keyword, IBThing, Class, pointer name
    __weak IBOutlet UIImageView *inputImageView;
    __weak IBOutlet UIButton *yesButton;
    __weak IBOutlet UIButton *noButton;
    __weak IBOutlet UIButton *confirmButton;
    NSArray *imagesDicts;
    NSDictionary *currentImage;
    NSMutableArray *images;
    BOOL isCorrect;
    int score;
    int order;
}
- (IBAction)decisionButtonPressed:(id)sender;
- (IBAction)confirmButtonPressed:(id)sender;

@end
