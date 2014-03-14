//
//  DebugViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "DebugViewController.h"

#import "PreTestViewController.h"
#import "PostTestViewController.h"
#import "Test.h"

#import "LanguageNamingViewController.h"
#import "LanguageComprehensionViewController.h"

@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tests = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Prepare the first test
    PreTestViewController *preTestViewController = [[PreTestViewController alloc] initWithNibName:@"PreTestViewController" bundle:nil];
    LanguageNamingViewController *languageNamingViewController = [[LanguageNamingViewController alloc] initWithNibName:@"LanguageNamingViewController" bundle:nil];
    PostTestViewController *postTestViewController = [[PostTestViewController alloc] initWithNibName:@"PostTestViewController" bundle:nil];
    Test *firstTest = [[Test alloc] initWithPreTest:preTestViewController test:languageNamingViewController postTest:postTestViewController navigationController:self.navigationController];
    [tests addObject:firstTest];
    
    // Prepare the second test
    PreTestViewController *preTestViewController2 = [[PreTestViewController alloc] initWithNibName:@"PreTestViewController" bundle:nil];
    LanguageComprehensionViewController *languageComprehensionViewController = [[LanguageComprehensionViewController alloc] initWithNibName:@"LanguageComprehensionViewController" bundle:nil];
    PostTestViewController *postTestViewController2 = [[PostTestViewController alloc] initWithNibName:@"PostTestViewController" bundle:nil];
    Test *secondTest = [[Test alloc] initWithPreTest:preTestViewController2 test:languageComprehensionViewController postTest:postTestViewController2 navigationController:self.navigationController];
    [tests addObject:secondTest];
}

-(void)viewWillAppear:(BOOL)animated
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{ return 1; }
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return [tests count];}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    Test *test = [tests objectAtIndex:[indexPath row]];
    NSString *cellText = [NSString stringWithFormat:@"Test %i: %@", [indexPath row], test];
    [cell.textLabel setText:cellText];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test *test = [tests objectAtIndex:[indexPath row]];
    [test startPreTest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
