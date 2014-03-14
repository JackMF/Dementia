//
//  LanguageNamingViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "LanguageNamingViewController.h"
#import "LanguageComprehensionViewController.h"

@interface LanguageNamingViewController ()

@end

@implementation LanguageNamingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        score = 0;
        order = 0;
        images = [[NSMutableArray alloc] init];
        NSString *imagesPlistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
        imagesDicts = [NSArray arrayWithContentsOfFile:imagesPlistPath];
        // Creating a sorting descriptor
        NSSortDescriptor *orderDescriptor = [[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES];
        // Sort the close stops
        imagesDicts = [imagesDicts sortedArrayUsingDescriptors:[NSArray arrayWithObjects:orderDescriptor, nil]];

    }
    return self;
}

-(void)loadNextImage
{
    if (order < [imagesDicts count]) {
        NSDictionary *imageDict = [imagesDicts objectAtIndex:order];
        UIImage *image = [UIImage imageNamed:[imageDict valueForKey:@"filename"]];
        [inputImageView setImage:image];
        order++;
    } else {
        [self showFinished];
    }
}

-(void)showFinished
{
    LanguageComprehensionViewController *languageComprehensionViewController = [[LanguageComprehensionViewController alloc] initWithNibName:@"LanguageComprehensionViewController" bundle:nil];
    [[self navigationController] pushViewController:languageComprehensionViewController animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadNextImage];
    
    //    [objectName methodNameWithArgument:argument andArgumentTwo:argument2]; == objectName.methodNameWithArguments(argument, argument2)
}

- (IBAction)decisionButtonPressed:(id)sender
{
    if (sender==yesButton) {
        isCorrect = YES;
        [yesButton setBackgroundColor:[UIColor redColor]];
    } else if (sender==noButton) {
        isCorrect = NO;
        [noButton setBackgroundColor:[UIColor redColor]];
    }
    [confirmButton setHidden:NO];
}

- (IBAction)confirmButtonPressed:(id)sender {
    // If we're correct, update the score for this test
    if (isCorrect) {
        score++;
    }
    
    NSLog(@"Score: %i", score);
    [yesButton setBackgroundColor:[UIColor clearColor]];
    [noButton setBackgroundColor:[UIColor clearColor]];

    [self loadNextImage];
    [confirmButton setHidden:YES];
    // Load the next image
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"LanguageNamingViewController: viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"LanguageNamingViewController: viewDidAppear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
