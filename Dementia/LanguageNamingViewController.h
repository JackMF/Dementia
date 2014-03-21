//
//  LanguageNamingViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestViewController.h"

@interface LanguageNamingViewController : TestViewController
{
    // memory_keyword, IBThing, Class, pointer name
    __weak IBOutlet UIImageView *inputImageView;
    __weak IBOutlet UILabel *question;
    NSArray *imagesDicts;
    NSDictionary *currentImage;
    BOOL answerWasCorrect;
    int currentImageOrder;
}

@end
