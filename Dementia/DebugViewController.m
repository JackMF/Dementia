//
//  DebugViewController.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "DebugViewController.h"
#import "Test.h"
#import "TestManager.h"
@interface DebugViewController ()

@end

@implementation DebugViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        tests = [[TestManager sharedInstance] tests];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
}

-(int)numberOfSectionsInTableView:(UITableView *)tableView{ return 1; }
-(int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{ return [tests count];}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    Test *test = [tests objectAtIndex:[indexPath row]];
    NSString *cellText = [NSString stringWithFormat:@"Test %i: %@", [indexPath row]+1, [test testName]];
    [cell.textLabel setText:cellText];
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:24.0]];
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Test *test = [tests objectAtIndex:[indexPath row]];
    [test launchWithNavigationController:self.navigationController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
