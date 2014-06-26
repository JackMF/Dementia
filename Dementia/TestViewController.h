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

@interface TestViewController : UIViewController <UIActionSheetDelegate>

@property (nonatomic) Test *test;
@property (nonatomic) ControlPanelViewController *controlPanelViewController;
-(void)animateElementOut:(id)element andBringBackWithValue:(id)value;

-(void)hasFinished;
-(void)didConfirmAnswer;

-(void)countdownTimerHasFinished;
-(void)timerStoppedWithTimeElapsed:(int)timeElapsed;

-(void)makeStaticControlPanel;
-(void)makeDynamicControlPanel;
-(void)makeControlPanelWithIsDynamic:(BOOL)isDynamic;

-(void)makeMultiControlPanelWithTitles:(NSArray *)titles andValues:(NSArray *)values;
-(void)updateMultiControlPanelValues:(NSArray *)newValues;

-(double)getVFIFromNumberOfWordsProduced:(int)numWordsProduced duration:(int)duration repeatDuration:(int)repeatDuration;
-(int)getScoreFromVFI:(double)vfi andDuration:(int)duration;

@end
