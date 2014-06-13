//
//  TestViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Test;
@class ControlPanelViewController;

@interface TestViewController : UIViewController

@property (nonatomic) Test *test;
@property (nonatomic) ControlPanelViewController *controlPanelViewController;
-(void)hasFinished;
-(void)didConfirmAnswer;
-(void)makeControlPanelWithIsDynamic:(BOOL)isDynamic;
-(void)makeStaticControlPanel;
-(void)makeDynamicControlPanel;
-(void)makeMultiControlPanelWithTitles:(NSArray *)titles andValues:(NSArray *)values;
-(void)countdownTimerHasFinished;
-(void)timerStoppedWithTimeElapsed:(int)timeElapsed;
-(void)animateElementOut:(id)element andBringBackWithValue:(id)value;
@end
