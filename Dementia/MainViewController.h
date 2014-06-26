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

@interface MainViewController : UIViewController <UIActionSheetDelegate>
{
	NSArray *tests;
	TestManager *testManager;
	DebugViewController *debugViewController;
	__weak IBOutlet UILabel *progressLabel;
	__weak IBOutlet UILabel *currentTestLabel;
	__weak IBOutlet UILabel *participantNameLabel;
	__weak IBOutlet UILabel *participantHospitalNumberLabel;
	__weak IBOutlet UIView *participantDetailsView;
	__weak IBOutlet UIButton *participantDetailsButton;
	__weak IBOutlet UIButton *testButton;
	__weak IBOutlet UIButton *testResultsButton;
}
- (IBAction)enterParticipantDetailsButtonPressed:(id)sender;
- (IBAction)testButtonPressed;
- (IBAction)endButtonPressed;

@end
