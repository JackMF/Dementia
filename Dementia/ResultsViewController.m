//
//  ResultsViewController.m
//  Dementia
//
//  Created by Chris on 20/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ResultsViewController.h"
#import "TestManager.h"
#import "Test.h"

@interface ResultsViewController ()

@end

@implementation ResultsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
		testManager = [TestManager sharedInstance];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self addDoneButton];
	[self setupScrollView];
	[self setupPatientDetails];
	[self setupTestScores];
}

-(void)setupTestScores
{

}

-(void)setupPatientDetails
{
	[dateOfTestingLabel setText:[testManager testDate]];
	[patientNameLabel setText:[testManager patientName]];
	[patientDateOfBirthLabel setText:[testManager patiendDateOfBirth]];
	[patientHospitalNumberLabel setText:[testManager patientHospitalNoOrAddress]];
	[patientAgeAtLeavingEducationLabel setText:[testManager patientAgeLeavingEducation]];
	[patientOccupationLabel setText:[testManager patientOccupation]];
	[patientHandednessLabel setText:[testManager patientHandedness]];
}

-(void)setupScrollView
{
	CGSize size = contentView.bounds.size;
	contentView.frame = CGRectMake(0, 0, size.width, size.height);
	[scrollView addSubview:contentView];
	scrollView.contentSize = size;
}

-(void)addDoneButton
{
	UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
	[self.navigationItem setRightBarButtonItem:closeButton];
}

-(void)done
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
