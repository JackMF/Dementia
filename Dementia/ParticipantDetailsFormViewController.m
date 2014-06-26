//
//  ParticipantDetailsFormViewController.m
//  Dementia
//
//  Created by Chris on 20/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ParticipantDetailsFormViewController.h"
#import "TestManager.h"

@interface ParticipantDetailsFormViewController ()

@end

@implementation ParticipantDetailsFormViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		tableFields = @[@"Date of Test", @"Participant Name / ID", @"Hospital No. or Address", @"Date of Birth",  @"Age at leaving full-time education", @"Occupation", @"Handedness"];
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
	UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(close)];
	[self.navigationItem setLeftBarButtonItem:cancelButton];

	[participantDetailsTableView deselectRowAtIndexPath:[participantDetailsTableView indexPathForSelectedRow] animated:NO];
	[participantDetailsTableView reloadData];
}

-(void)done
{

	if (![self getTestFieldValueWithTag:2] || ![self getTestFieldValueWithTag:3]) {
		UIAlertView *alertView = [[UIAlertView alloc]
		    initWithTitle:@"Participant details missing"
		    message:@"Please ensure you have entered:\n \u2022 Participant Name/ID\n \u2022 Hospital No. or Address" delegate:self
		    cancelButtonTitle:@"Okay"
		    otherButtonTitles:nil];
		[alertView show];
	} else {
		[self updateTestManagerParticipantDetails];
		[self close];
	}
}

- (IBAction)doneButtonPressed:(id)sender {
	[self done];
}

-(void)updateTestManagerParticipantDetails
{
	[testManager setTestDate:[self getTestFieldValueWithTag:1]];
	[testManager setParticipantName:[self getTestFieldValueWithTag:2]];
	[testManager setParticipantHospitalNoOrAddress:[self getTestFieldValueWithTag:3]];
	[testManager setParticipantDateOfBirth:[self getTestFieldValueWithTag:4]];
	[testManager setParticipantAgeLeavingEducation:[self getTestFieldValueWithTag:5]];
	[testManager setParticipantOccupation:[self getTestFieldValueWithTag:6]];
	[testManager setParticipantHandedness:[self getTestFieldValueWithTag:7]];
}

-(NSString *)getTestFieldValueWithTag:(int)tag
{
	UITextField *textField = (UITextField *)[self.view viewWithTag:tag];
	NSString *text = [textField text];
	if ([text isEqualToString:@""]) return nil;
	return [textField text];
}

-(NSString *)getFieldValueWithIndexPath:(NSIndexPath *)indexPath
{
	int row = (int) [indexPath row];
	switch (row)
	{
	case 0: {
		NSDate *currentDate = [NSDate date];
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setDateFormat:@"dd/MM/yyyy"];
		return [formatter stringFromDate:currentDate];
		break;
	}
	case 1:
		return [testManager participantName];
	case 2:
		return [testManager participantHospitalNoOrAddress];
	case 3:
		return [testManager participantDateOfBirth];
	case 4:
		return [testManager participantAgeLeavingEducation];
	case 5:
		return [testManager participantOccupation];
	case 6:
		return [testManager participantHandedness];
	default:
		break;
	}
	return @"";
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
	if (!cell)
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

	NSString *cellLabel = [tableFields objectAtIndex:row];
	[cell.textLabel setText:cellLabel];
	[cell.textLabel setFont:[UIFont systemFontOfSize:25.0]];
	if (row <= 2)
		[cell.textLabel setFont:[UIFont boldSystemFontOfSize:25.0]];

	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(768-340, 0, 320, 100)];
	[textField setDelegate:self];
	[textField setTag:row+1];

	[textField setFont:[UIFont boldSystemFontOfSize:25.0]];
	[textField setTextAlignment:NSTextAlignmentRight];

	[textField setTextColor:[UIColor blackColor]];
	[textField setEnabled:YES];

	[textField setPlaceholder:@""];
	NSString *currentValue = [self getFieldValueWithIndexPath:indexPath];
	if (currentValue) [textField setText:currentValue];
	else [textField setText:@""];

	if (row == 0) {
		[textField setTextColor:[UIColor grayColor]];
		[textField setEnabled:NO];
	}

	textField.keyboardType = UIKeyboardTypeDefault;
	if (row == 2)
		textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
	if (row == 3)
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	int row = [indexPath row];
	UITextField *nextField = (UITextField *)[self.view viewWithTag:row+1];
	[nextField becomeFirstResponder];
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
