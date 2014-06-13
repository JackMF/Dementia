//
//  MultiControlPanelViewController.m
//  Dementia
//
//  Created by Chris on 31/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MultiControlPanelViewController.h"

@interface MultiControlPanelViewController ()

@end

@implementation MultiControlPanelViewController
@synthesize answerScore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

-(void)setButtonTitles:(NSArray *)titles andValues:(NSArray *) values
{
	buttonTitles = titles;
	buttonValues = values;
}


- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
	[buttonOne setTitle:buttonTitles[0] forState:UIControlStateNormal];
	[buttonTwo setTitle:buttonTitles[1] forState:UIControlStateNormal];
	[buttonThree setTitle:buttonTitles[2] forState:UIControlStateNormal];
}

-(void)decisionButtonPressed:(id)sender
{
	[self resetDecisionButtons];
	if (sender==buttonOne)
		answerScore = (int)[[buttonValues objectAtIndex:0] integerValue];
	else if (sender==buttonTwo)
		answerScore = (int)[[buttonValues objectAtIndex:1] integerValue];
	else if (sender==buttonThree)
		answerScore = (int)[[buttonValues objectAtIndex:2] integerValue];
	[(UIButton *)sender setBackgroundColor :[UIColor redColor]];
	//[(UIButton *)sender setTintColor:[UIColor greenColor]];
	[confirmButton setHidden:NO];           // Show the confirm button
}

// Resets the decision buttons to their original state
-(void)resetDecisionButtons
{
	[buttonOne setBackgroundColor:[UIColor clearColor]];
	[buttonTwo setBackgroundColor:[UIColor clearColor]];
	[buttonThree setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
