//
//  ParticipantDetailsFormViewController.h
//  Dementia
//
//  Created by Chris on 20/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestManager;

@interface ParticipantDetailsFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
{
	__weak IBOutlet UITableView *participantDetailsTableView;
	NSArray *tableFields;
	NSMutableArray *tableValues;
	TestManager *testManager;
}

- (IBAction)doneButtonPressed:(id)sender;
-(void)updateTestManagerParticipantDetails;

@end
