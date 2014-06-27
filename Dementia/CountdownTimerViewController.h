//
//  TimerViewController.h
//  Dementia
//
//  Created by Chris on 10/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestViewController;

@interface CountdownTimerViewController : UIViewController
{
	__weak IBOutlet UISegmentedControl *speakingWritingSegmentedControl;
	__weak IBOutlet UILabel *countdownLabel;
	__weak IBOutlet UIButton *startButton;
	__weak IBOutlet UIButton *stopButton;
	NSTimer *countdownTimer;

}
- (IBAction)startButtonPressed:(id)sender;
- (IBAction)stopButtonPressed:(id)sender;
-(void)updateCountdownLabel;
@property TestViewController *testVCDelegate;
@property int countdownDuration;
- (IBAction)speakingWritingValueChanged;

@end
