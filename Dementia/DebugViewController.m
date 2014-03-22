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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tests count];
}
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
	NSString *cellText = [NSString stringWithFormat:@"Test %i: %@", (int)[indexPath row]+1, [test getFullTestName]];
	[cell.textLabel setText:cellText];
	[cell.textLabel setFont:[UIFont boldSystemFontOfSize:25.0]];
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Test *test = [tests objectAtIndex:[indexPath row]];                 // Get the test for this row
	[test launchWithNavigationController:self.navigationController];    // Start the test, loading views on the navigation controller
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
