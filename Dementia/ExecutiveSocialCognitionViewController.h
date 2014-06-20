//
//  SocialCognitionPartAViewController.h
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"

@interface ExecutiveSocialCognitionViewController : TestViewController
{
	int currentQuestionOrder;
	int currentStageOrder;
	NSArray *questions;
	NSMutableArray *userAnswers;
	__weak IBOutlet UIView *questionView;
	__weak IBOutlet UIButton *answer0Button;
	__weak IBOutlet UIButton *answer1Button;
	__weak IBOutlet UIButton *answer2Button;
	__weak IBOutlet UIButton *answer3Button;
	__weak IBOutlet UIImageView *faceImageView;
}
- (IBAction)answerButtonPressed:(id)sender;
-(void)populateQuestionView;
-(int)getIndexForSender:(id)sender;

@end
