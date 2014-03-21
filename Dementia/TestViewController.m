//
//  TestViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"


@interface TestViewController ()
@end

@implementation TestViewController
@synthesize test;
@synthesize controlPanelViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        controlPanelViewController = [[ControlPanelViewController alloc] initWithNibName:@"ControlPanelViewController" bundle:nil];

    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.test setTestScore:0];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self.test hasControlPanel]) {
        // Add the control panel to the view
        [self addChildViewController:controlPanelViewController];
        CGRect cpFrame = CGRectMake(0.0, 1024.0-185.0, 768.0, 185.0);
        [controlPanelViewController.view setFrame:cpFrame];
        [controlPanelViewController setTestVSDelegate:self];
        [self.view addSubview:controlPanelViewController.view];
        [controlPanelViewController didMoveToParentViewController:self];
        
        // Add the control event stuff
        UITapGestureRecognizer *singleFingerTap =
        [[UITapGestureRecognizer alloc] initWithTarget:controlPanelViewController action:@selector(toggleControlPanel)];
        [self.view addGestureRecognizer:singleFingerTap];

    }
}

-(void)hasFinished
{
    if (self.test) [self.test startPostTest]; // If we have a test, start the post test
    else {
//        NSString *scoreString = [NSString stringWithFormat:@"%i points", score];
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished! (debug mode)" message:scoreString delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
//        [alert show];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
