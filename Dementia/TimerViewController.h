//
//  TimerViewController.h
//  Dementia
//
//  Created by Chris on 11/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestViewController;

@interface TimerViewController : UIViewController
{
	__weak IBOutlet UILabel *timerLabel;
	__weak IBOutlet UIButton *startButton;
	__weak IBOutlet UIButton *stopButton;
	NSTimer *timer;
	NSDate *startDate;
}
- (IBAction)startButtonPressed;
- (IBAction)stopButtonPressed;
@property TestViewController *testVCDelegate;

@end
