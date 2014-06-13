//
//  ExecutiveReverseDigitSpanViewController.m
//  Dementia
//
//  Created by Jack Fletcher on 24/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ExecutiveReverseDigitSpanViewController.h"
#import "TestViewController.h"
#import "Test.h"
#import "ControlPanelViewController.h"
#import "ButtonListViewController.h"
#define kImageViewAnimationDuration 0.2


@interface ExecutiveReverseDigitSpanViewController ()

@end

@implementation ExecutiveReverseDigitSpanViewController
@synthesize test;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];

	// Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	digitsOrder = 0;
	currentScore = 0;
	rowOfPreviousAnswer = 0;
	//[super makeStaticControlPanel];
	digitsArray = [test buttonText];
	[self loadNextDigits];
	[self makeButtons];
}

-(void)makeButtons {


	NSMutableString *currentDigits = [digitsArray objectAtIndex:digitsOrder];

	NSString* reversedDigits = [self reverseString:currentDigits];
	[super viewDidLoad];


	NSArray *digits= [reversedDigits componentsSeparatedByString:@" "];
	numberOfDigits = [digits count];

	buttonListViewController = [[ButtonListViewController alloc] initWithNibName:@"ButtonListViewController" bundle:nil];
	// Add the control panel to the view
	[self addChildViewController:buttonListViewController];

	CGRect cpFrame = CGRectMake(80.0, 600.0, 600.0, 150.0);
	[buttonListViewController.view setFrame:cpFrame];

	NSArray *buttonLabelValues = digits;

	[buttonListViewController setButtonLabelValues:buttonLabelValues];

	[self.view addSubview:buttonListViewController.view];
	[buttonListViewController didMoveToParentViewController:self];

}

-(void)loadNextDigits {

	NSString *newDigits = [digitsArray objectAtIndex:digitsOrder];
	[super animateElementOut:toReverseLabel andBringBackWithValue:newDigits];
}


-(NSString*)reverseString:(NSString*)toReverse
{

	NSMutableString *reversedString = [NSMutableString string];
	NSInteger charIndex = [toReverse length];
	while (charIndex > 0) {
		charIndex--;
		NSRange subStrRange = NSMakeRange(charIndex, 1);
		[reversedString appendString:[toReverse substringWithRange:subStrRange]];
	}

	NSString *reversed = reversedString;
	//NSString *reverssed = [NSString stringWithString:reversedString];

	return reversed;
}

-(void)nextButtonPressed:(id)sender {

	//Caclulating Score
	int curentRow = numberOfDigits -1;
	BOOL isCorrect = ([buttonListViewController getNumberOfCorrectAnswers] == numberOfDigits);

	//Checking if we need to stop
	if(curentRow == rowOfPreviousAnswer) {
		if (!previousAnswerCorrect && !isCorrect) {
			[super hasFinished];
		}
		else if (isCorrect) [test addToTestScore:1];
	}

	else{

		if (isCorrect) [test addToTestScore:1];
	}
	//Loading Next Question
	previousAnswerCorrect = isCorrect;
	rowOfPreviousAnswer = curentRow;
	digitsOrder++;
	if (digitsOrder < [digitsArray count]) {
		[self loadNextDigits];
		[self makeButtons];
	}

	else{
		[super hasFinished];
	}

}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
