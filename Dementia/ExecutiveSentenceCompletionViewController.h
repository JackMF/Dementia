//
//  ExecutiveSentenceCompletionViewController.h
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"

@interface ExecutiveSentenceCompletionViewController : TestViewController
{
	int currentQuestionOrder;
	NSArray *questions;
	__weak IBOutlet UILabel *toCompleteLabel;
}

@end
