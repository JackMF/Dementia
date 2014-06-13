//
//  MemoryDelayedRecognitionViewController.h
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"

@interface MemoryDelayedRecognitionViewController : TestViewController
{
	NSArray *questions;
	__weak IBOutlet UILabel *questionLabel;
	int currentQuestionOrder;
}

@end
