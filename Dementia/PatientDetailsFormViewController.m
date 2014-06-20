//
//  PatientDetailsFormViewController.m
//  Dementia
//
//  Created by Chris on 20/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "PatientDetailsFormViewController.h"
#import "TestManager.h"

@interface PatientDetailsFormViewController ()

@end

@implementation PatientDetailsFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		tableFields = @[@"Date of Test", @"Name", @"Date of Birth", @"Hospital No. or Address", @"Age at leaving full-time education", @"Occupation", @"Handedness"];
		tableValues = [NSMutableArray new];
		testManager = [TestManager sharedInstance];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
	[self.navigationItem setRightBarButtonItem:doneButton];

	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
	[self.navigationItem setLeftBarButtonItem:cancelButton];

	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
	[tableView reloadData];
}

-(void)done
{
	[self updateTestManagerPatientDetails];
	[self close];
}

-(void)updateTestManagerPatientDetails
{
	[testManager setTestDate:[self getTestFieldValueWithTag:1]];
	[testManager setPatientName:[self getTestFieldValueWithTag:2]];
	[testManager setPatiendDateOfBirth:[self getTestFieldValueWithTag:3]];
	[testManager setPatientHospitalNoOrAddress:[self getTestFieldValueWithTag:4]];
	[testManager setPatientAgeLeavingEducation:[self getTestFieldValueWithTag:5]];
	[testManager setPatientOccupation:[self getTestFieldValueWithTag:6]];
	[testManager setPatientHandedness:[self getTestFieldValueWithTag:7]];
}

-(NSString *)getTestFieldValueWithTag:(int)tag
{
	UITextField *textField = (UITextField *)[self.view viewWithTag:tag];
	return [textField text];
}

-(void)close
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [tableFields count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 100.0;
}

-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	int row = (int) [indexPath row];

	NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	NSString *cellLabel = [tableFields objectAtIndex:row];
	[cell.textLabel setText:cellLabel];
	[cell.textLabel setFont:[UIFont boldSystemFontOfSize:25.0]];

	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(768-340, 0, 320, 100)];
	[textField setDelegate:self];
	[textField setTag:row+1];

	[textField setFont:[UIFont boldSystemFontOfSize:25.0]];
	[textField setTextAlignment:NSTextAlignmentRight];

	[textField setTextColor:[UIColor blackColor]];
	[textField setEnabled:YES];
	[textField setPlaceholder:@""];

	if (row == 0) {
		[textField setTextColor:[UIColor grayColor]];
		[textField setEnabled:NO];
		NSDate *currentDate = [NSDate date];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd/MM/yyyy"];
		[textField setText:[formatter stringFromDate:currentDate]];
	}

	textField.keyboardType = UIKeyboardTypeDefault;
	if (row == 2)
		textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	if (row == 4)
		textField.keyboardType = UIKeyboardTypeNumberPad;

	textField.returnKeyType = UIReturnKeyNext;
	if (row == 6)
		textField.returnKeyType = UIReturnKeyDone;


	textField.backgroundColor = [UIColor whiteColor];
	textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support

	[cell.contentView addSubview:textField];

	return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if ([textField tag]==7) {
		// Hide the keyboard
		[textField resignFirstResponder];
		return NO;
	} else {
		int nextTag = (int) [textField tag]+1;
		UITextField *nextField = (UITextField *)[self.view viewWithTag:nextTag];
		[nextField becomeFirstResponder];
		return NO;
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
