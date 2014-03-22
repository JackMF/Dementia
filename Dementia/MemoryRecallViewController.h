//
//  MemoryRecallViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
@class ButtonListViewController;
@interface MemoryRecallViewController : TestViewController
{
	__weak IBOutlet UITextView *storyTextView;
	ButtonListViewController *buttonListViewController;
}
@end
