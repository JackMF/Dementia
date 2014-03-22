//
//  MemoryRecallViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface MemoryRecallViewController : TestViewController
{
	NSString *story;
	NSArray *namesOfButtons;
	int currentScore;
	__weak IBOutlet UILabel *testL;
	__weak IBOutlet UILabel *storyLabel;
}
@end
