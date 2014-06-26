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
}

-(void)viewWillAppear:(BOOL)animated
{
	[self setupParticipantDetails];
	[self setupTestScores];
	[self setupCategoryScores];
	[super viewWillAppear:animated];
}

-(void)setupCategoryScores
{
	[languageLabel setText:[testManager categoryScoreWithCategoryName:@"Language"]];
	[verbalFluencyLabel setText:[testManager categoryScoreWithCategoryName:@"Verbal Fluency"]];
	[executiveLabel setText:[testManager categoryScoreWithCategoryName:@"Executive"]];
	[memoryLabel setText:[testManager categoryScoreWithCategoryName:@"Memory"]];
	[visuospatialLabel setText:[testManager categoryScoreWithCategoryName:@"Visuospatial"]];
	[alsSpecificLabel setText:[testManager categoryScoreWithCategoryName:@"alsSpecific"]];
	[alsNonSpecificLabel setText:[testManager categoryScoreWithCategoryName:@"alsNonSpecific"]];
	[ecasScoreLabel setText:[testManager ecasScore]];
}

-(void)setupTestScores
{
	[languageNamingLabel setText:[testManager scoreForTestWithIndex:0]];
	[languageComprehensionLabel setText:[testManager scoreForTestWithIndex:1]];
	[memoryRecallLabel setText:[testManager scoreForTestWithIndex:2]];
	[languageSpellingLabel setText:[testManager scoreForTestWithIndex:3]];

	[fluencyLetterSLabel setText:[testManager scoreForTestWithIndex:4]];
	Test *fluencySTest = [[testManager tests] objectAtIndex:4];
	if ([fluencySTest vfi]) {
		NSString *fluencySVFIText = [NSString stringWithFormat:@"%.2lf",[[fluencySTest vfi] doubleValue]];
		[fluencyLetterSVFILabel setText:fluencySVFIText];
	}

	[executiveReverseLabel setText:[testManager scoreForTestWithIndex:5]];
	[executiveAlternationLabel setText:[testManager scoreForTestWithIndex:6]];

	[fluencyLetterTLabel setText:[testManager scoreForTestWithIndex:7]];
	Test *fluencyTTest = [[testManager tests] objectAtIndex:7];
	if ([fluencyTTest vfi]) {
		NSString *fluencyTVFIText = [NSString stringWithFormat:@"%.2lf",[[fluencyTTest vfi] doubleValue]];
		[fluencyLetterTVFILabel setText:fluencyTVFIText];
	}

	[visuospatialDotLabel setText:[testManager scoreForTestWithIndex:8]];
	[visuospatialCubeLabel setText:[testManager scoreForTestWithIndex:9]];
	[visuospatialNumberLabel setText:[testManager scoreForTestWithIndex:10]];
	[executiveSentenceLabel setText:[testManager scoreForTestWithIndex:11]];
	[executiveSocialCognitionLabel setText:[testManager scoreForTestWithIndex:12]];
	[memoryDelayedRecallLabel setText:[testManager scoreForTestWithIndex:13]];
	[memoryDelayedRecognitionLabel setText:[testManager scoreForTestWithIndex:14]];
}

-(void)setupParticipantDetails
{
	[dateOfTestingLabel setText:[testManager testDate]];
	[participantNameLabel setText:[testManager participantName]];
	[participantDateOfBirthLabel setText:[testManager participantDateOfBirth]];
	[participantHospitalNumberLabel setText:[testManager participantHospitalNoOrAddress]];
	[participantAgeAtLeavingEducationLabel setText:[testManager participantAgeLeavingEducation]];
	[participantOccupationLabel setText:[testManager participantOccupation]];
	[participantHandednessLabel setText:[testManager participantHandedness]];
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

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
