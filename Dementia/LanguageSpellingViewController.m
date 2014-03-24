//
//  LanguageSpellingViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 22/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageSpellingViewController.h"
#import "Test.h"

@interface LanguageSpellingViewController ()

@end

@implementation LanguageSpellingViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    questionOrder = 0;
    toSpellArray = [test toSpell];
    [toSpellLabel setText:[toSpellArray objectAtIndex:questionOrder]];
     
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
