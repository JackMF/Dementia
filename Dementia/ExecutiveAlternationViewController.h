//
//  ExecutiveAlternationViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 25/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import <UIKit/UIKit.h>

@class ButtonListViewController;

@interface ExecutiveAlternationViewController : TestViewController
{
    __weak IBOutlet UIButton *finishButton;
    NSArray *buttonText;
    ButtonListViewController *buttonListViewController;
}

- (IBAction)finishButtonPressed:(id)sender;

@end
