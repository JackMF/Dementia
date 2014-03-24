//
//  LanguageSpellingViewController.h
//  Dementia
//
//  Created by Jack Fletcher on 22/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface LanguageSpellingViewController : TestViewController
{
    
    
    __weak IBOutlet UIButton *tempNextButton;
    __weak IBOutlet UILabel *toSpellLabel;
    int wordOrder;
    NSArray *toSpellArray;
    
}


@end
