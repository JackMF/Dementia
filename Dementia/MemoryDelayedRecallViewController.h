//
//  MemoryDelayedRecallViewController.h
//  Dementia
//
//  Created by Chris on 26/05/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import <UIKit/UIKit.h>

@class ButtonListViewController;

@interface MemoryDelayedRecallViewController : TestViewController
{
    __weak IBOutlet UITextView *instructText;
    ButtonListViewController *buttonListViewController;
}
- (IBAction)finishButtonPressed:(id)sender;
@end


