//
//  FluencyLetterSViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 24/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
@class CountdownTimerViewController;

@interface FluencyLetterSViewController : TestViewController <UIAlertViewDelegate, UITextFieldDelegate>
{
	CountdownTimerViewController *timerViewController;
	UIAlertView *finishedAlertView;
}

@end
