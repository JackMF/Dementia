//
//  PreTestViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
@class Test;
@interface PreTestViewController : TestViewController
{
	__weak IBOutlet UITextView *textView;
}
- (IBAction)startButtonPressed;
@property (nonatomic) Test *test;
@end
