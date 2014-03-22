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
	BOOL isSelected;
	int currentQuestionOrder;
	NSString *currentButtonSelected;
	NSString * correctAnswer;

	__weak IBOutlet UILabel *questionLabel;
	__weak IBOutlet UIButton *nextQuesiton;
}
- (IBAction)imageButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

@end
