//
//  ControlPanelViewController.h
//  Dementia
//
//  Created by Chris on 16/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestViewController;

@interface ControlPanelViewController : UIViewController
{
	__weak IBOutlet UIButton *yesButton;
	__weak IBOutlet UIButton *noButton;
	__weak IBOutlet UIButton *confirmButton;
	__weak IBOutlet UIView *controlPanelView;
	ControlPanelViewController *cpVC;


}
- (IBAction)decisionButtonPressed:(id)sender;
- (IBAction)confirmButtonPressed:(id)sender;
@property (nonatomic) TestViewController *testVSDelegate;
@property (nonatomic) BOOL isDisplayed;
@property (nonatomic) BOOL answerWasCorrect;
@property (nonatomic) BOOL isDynamic;
- (void)toggleControlPanel;
-(void)showControlPanel;
-(void)hideControlPanel;
@end
