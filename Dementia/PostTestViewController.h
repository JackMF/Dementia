//
//  PostTestViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"
@class Test;
@class TestManager;
@interface PostTestViewController : TestViewController
{
	__weak IBOutlet UITextView *textView;
	TestManager *testManager;
}
- (IBAction)endButtonPressed;
@property (nonatomic) Test *test;
@end
