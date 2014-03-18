//
//  LanguageComprehensionViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface LanguageComprehensionViewController : TestViewController
{
    NSArray *imagesDicts;
    BOOL isSelected;
}
- (IBAction)imageButtonPressed:(id)sender;
@end
