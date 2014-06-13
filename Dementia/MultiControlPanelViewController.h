//
//  MultiControlPanelViewController.h
//  Dementia
//
//  Created by Chris on 31/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ControlPanelViewController.h"

@interface MultiControlPanelViewController : ControlPanelViewController
{
	__weak IBOutlet UIButton *buttonOne;
	__weak IBOutlet UIButton *buttonTwo;
	__weak IBOutlet UIButton *buttonThree;
	NSArray *buttonTitles;
	NSArray *buttonValues;
}
@property (nonatomic) int answerScore;
-(void)setButtonTitles:(NSArray *)titles andValues:(NSArray *) values;

@end
