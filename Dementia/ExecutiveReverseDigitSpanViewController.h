//
//  ExecutiveReverseDigitSpanViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 24/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
@class ButtonListViewController;

@interface ExecutiveReverseDigitSpanViewController : TestViewController
{
    NSArray *digitsArray;
    int digitsOrder;
    ButtonListViewController *buttonListViewController;
    
    __weak IBOutlet UIButton *nextButton;
    __weak IBOutlet UILabel *toReverseLabel;
}
- (IBAction)nextButtonPressed:(id)sender;


@end
