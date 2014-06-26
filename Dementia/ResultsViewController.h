//
//  ResultsViewController.h
//  Dementia
//
//  Created by Chris on 20/06/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TestManager;

@interface ResultsViewController : UIViewController <UIScrollViewDelegate>
{
	TestManager *testManager;

	__weak IBOutlet UIScrollView *scrollView;
	__weak IBOutlet UIView *contentView;

	__weak IBOutlet UILabel *dateOfTestingLabel;
	__weak IBOutlet UILabel *participantNameLabel;
	__weak IBOutlet UILabel *participantDateOfBirthLabel;
	__weak IBOutlet UILabel *participantHospitalNumberLabel;
	__weak IBOutlet UILabel *participantAgeAtLeavingEducationLabel;
	__weak IBOutlet UILabel *participantOccupationLabel;
	__weak IBOutlet UILabel *participantHandednessLabel;

	__weak IBOutlet UILabel *languageNamingLabel;
	__weak IBOutlet UILabel *languageComprehensionLabel;
	__weak IBOutlet UILabel *memoryRecallLabel;
	__weak IBOutlet UILabel *languageSpellingLabel;
	__weak IBOutlet UILabel *fluencyLetterSLabel;
	__weak IBOutlet UILabel *executiveReverseLabel;
	__weak IBOutlet UILabel *executiveAlternationLabel;
	__weak IBOutlet UILabel *fluencyLetterTLabel;
	__weak IBOutlet UILabel *visuospatialDotLabel;
	__weak IBOutlet UILabel *visuospatialCubeLabel;
	__weak IBOutlet UILabel *visuospatialNumberLabel;
	__weak IBOutlet UILabel *executiveSentenceLabel;
	__weak IBOutlet UILabel *executiveSocialCognitionLabel;
	__weak IBOutlet UILabel *memoryDelayedRecallLabel;
	__weak IBOutlet UILabel *memoryDelayedRecognitionLabel;

	__weak IBOutlet UILabel *languageLabel;
	__weak IBOutlet UILabel *verbalFluencyLabel;
	__weak IBOutlet UILabel *executiveLabel;
	__weak IBOutlet UILabel *alsSpecificLabel;

	__weak IBOutlet UILabel *memoryLabel;
	__weak IBOutlet UILabel *visuospatialLabel;
	__weak IBOutlet UILabel *alsNonSpecificLabel;

	__weak IBOutlet UILabel *ecasScoreLabel;
}

@end
