//
//  MainViewController.h
//  Dementia
//
//  Created by Chris on 19/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestManager;
@class Test;
@class DebugViewController;

@interface MainViewController : UIViewController
{
	NSArray *tests;
	int currentTestOrder;
	TestManager *testManager;
	Test *currentTest;
	DebugViewController *debugViewController;
	__weak IBOutlet UILabel *progressLabel;
	__weak IBOutlet UILabel *currentTestLabel;
}

- (IBAction)continueButtonPressed;
- (IBAction)endButtonPressed;

@end
