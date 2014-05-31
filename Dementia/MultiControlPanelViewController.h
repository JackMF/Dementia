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
}
@property (nonatomic) int answerScore;
@property (nonatomic) NSArray *buttonTitles;
-(void)setButtonTitles:(NSArray *)titles;

@end
