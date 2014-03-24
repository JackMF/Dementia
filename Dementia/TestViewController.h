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
-(void)makeControlPanel;
-(void)makeStaticControlPanel;
-(void)makeDynamicControlPanel;
-(void)showContolPanel;
@end
