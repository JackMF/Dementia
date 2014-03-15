//
//  LanguageComprehensionViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageComprehensionViewController.h"
#import "Test.h"

@interface LanguageComprehensionViewController ()

@end

@implementation LanguageComprehensionViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [test testName];
    imagesDicts = [test imageDictionaries];
    for (NSDictionary *imageDict in imagesDicts) {
        UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
        int tag = [[imageDict valueForKey:@"order"] integerValue]+1;
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:newImage forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButtonPressed:(id)sender {
    UIButton* button = (UIButton*)sender;
    button.selected = !button.selected;
    CGRect buttonFrame = button.frame;
    double borderSize = 10;
    CGRect borderFrame = CGRectMake(buttonFrame.origin.x-borderSize, buttonFrame.origin.y-borderSize, buttonFrame.size.width + (borderSize*2), buttonFrame.size.height + (borderSize*2));
    UIView *borderView = [[UIView alloc] initWithFrame:borderFrame];
    if (button.selected) [borderView setBackgroundColor:[UIColor greenColor]];
    else [borderView setBackgroundColor:[UIColor whiteColor]];
    [self.view insertSubview:borderView belowSubview:button];
}
@end
