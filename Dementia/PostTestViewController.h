//
//  PostTestViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Test;
@interface PostTestViewController : UIViewController
{
	__weak IBOutlet UILabel *titleLabel;
	__weak IBOutlet UITextView *textView;
}
- (IBAction)endButtonPressed;
@property (nonatomic) Test *test;
@end
