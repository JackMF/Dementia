//
//  LanguageComprehensionViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface LanguageComprehensionViewController : TestViewController
{
	NSArray *imagesDicts;
	NSArray *questionDicts;
	int currentQuestionOrder;
	UIButton *currentlySelectedButton;
	NSString *correctAnswer;

	CGPoint questionCenter;

	__weak IBOutlet UIButton *nextQuestionButton;
	__weak IBOutlet UILabel *questionLabel;
}
- (IBAction)imageButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

@end
