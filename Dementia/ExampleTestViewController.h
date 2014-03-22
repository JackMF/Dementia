//
//  ExampleTestViewController.h
//  Dementia
//
//  Created by Chris on 16/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"

@interface ExampleTestViewController : TestViewController
{
	__weak IBOutlet UILabel *infoLabel;
	__weak IBOutlet UIButton *pressME;
	int currentScore;
}
-(IBAction)finishButtonPressed;

@end
