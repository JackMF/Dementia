//
//  MemoryRecallViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 18/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "MemoryRecallViewController.h"
#import "Test.h"

@interface MemoryRecallViewController ()

@end

@implementation MemoryRecallViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    currentScore=0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [test getFullTestName];
    story = [test story];
    [storyLabel setText:story];
    
    
    NSLog(@"Story: %@", story);
    namesOfButtons = [test buttonNames];
    
    int tag = 1;
    for (NSString *buttonName in namesOfButtons) {
        UIButton *button = (UIButton *) [self.view viewWithTag:tag];
        [button setTitle:buttonName forState:UIControlStateNormal];
        tag++;
        
    //[super hasFinishedTestWithScore:currentScore];
    
        
    }
    
    //for ()
    
    /*for (NSDictionary *imageDict in imagesDicts) {
        UIImage *newImage = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
        [newImage setAccessibilityIdentifier:[imageDict valueForKey:@"filename"]];
        int tag = [[imageDict valueForKey:@"order"] integerValue]+1;
        UIButton *button = (UIButton *)[self.view viewWithTag:tag];
        [button setImage:newImage forState:UIControlStateNormal];
    }*/
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
