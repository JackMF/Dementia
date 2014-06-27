//
//  TestManager.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "TestManager.h"
#import "Test.h"

@implementation TestManager
static TestManager *_sharedInstance;
@synthesize tests;
@synthesize testDate, participantAgeLeavingEducation, participantOccupation, participantHandedness, participantName, participantDateOfBirth;
@synthesize currentTestOrder;

-(id)init
{
	if (self = [super init]) {
		currentTestOrder = 0;
		[self loadTests];
	}
	return self;
}

// Loads the test details from the plist file
-(void)loadTests
{
	// Find the path for the test plist files
	NSString *testsPlistPath = [[NSBundle mainBundle] pathForResource:@"Tests" ofType:@"plist"];
	// Load the array of test dictionaries
	NSArray *loadedTestDicts = [NSArray arrayWithContentsOfFile:testsPlistPath];
	// Sort them by 'order'
	loadedTestDicts = [loadedTestDicts sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];

	NSMutableArray *newTests = [[NSMutableArray alloc] init];
	for (NSDictionary *testDict in loadedTestDicts) {
		Test *newTest = [[Test alloc] initWithPlistDict:testDict]; // Instantiate a new Test objects based on this dict
		if (newTest) {
			[newTests addObject:newTest];                              // Add the test to our newTests
		} else {
			NSLog(@"Test %@ fail to load test",[testDict valueForKey:@"testName"]);
		}
	}
	tests = newTests;
}

-(NSString *)scoreForTestWithIndex:(int)index
{
	Test *test = [tests objectAtIndex:index];
	if (![test isComplete]) return nil;

	int score = [test score];
	int maxScore = [test maxScore];
	return [NSString stringWithFormat:@"%i/%i", score, maxScore];
}

-(NSString *)categoryScoreWithCategoryName:(NSString *)categoryName
{
	int categoryTotal = 0;
	int maxTotal = 0;
	if ([categoryName isEqualToString:@"alsSpecific"]) {
		for (NSString *cat in @[@"Language",@"Verbal Fluency",@"Executive"]) {
			NSNumber *catScore = [self scoreForCategory:cat];
			if (!catScore) return nil;
			categoryTotal += [catScore integerValue];
			maxTotal += [[self maxForCategory:cat] integerValue];
		}
		return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
	} else if ([categoryName isEqualToString:@"alsNonSpecific"]) {
		for (NSString *cat in @[@"Memory",@"Visuospatial"]) {
			NSNumber *catScore = [self scoreForCategory:cat];
			if (!catScore) return nil;
			categoryTotal += [catScore integerValue];
			maxTotal += [[self maxForCategory:cat] integerValue];
		}
		return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
	}
	categoryTotal = [[self scoreForCategory:categoryName] integerValue];
	maxTotal = [[self maxForCategory:categoryName] integerValue];
	return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
}

-(NSNumber *)scoreForCategory:(NSString *)category
{
	int categoryTotal = 0;
	for (Test *test in tests) {
		if ([[test categoryName] isEqualToString:category]) {
			if (![test isComplete]) return nil;
			categoryTotal += [test score];
		}
	}
	return [NSNumber numberWithInt:categoryTotal];

}

-(NSNumber *)maxForCategory:(NSString *)category
{
	int maxTotal = 0;
	for (Test *test in tests) {
		if ([[test categoryName] isEqualToString:category]) maxTotal += [test maxScore];
	}
	return [NSNumber numberWithInt:maxTotal];

}

-(NSString *)getEcasScoreText
{
	int total = 0;
	int maxTotal = 0;
	for (Test *test in tests) {
		if (![test isComplete]) return nil;
		total += [test score];
		maxTotal += [test maxScore];
	}
	return [NSString stringWithFormat:@"%i/%i", total, maxTotal];
}

-(NSNumber *)ecasScore
{
	int total = 0;
	for (Test *test in tests) {
		if (![test isComplete]) return nil;
		total += [test score];
	}
	return [NSNumber numberWithInt:total];
}

// Returns a shared instance of the test manager
+(TestManager *)sharedInstance
{
	if (!_sharedInstance) { // If we don't have a shared instance
		_sharedInstance = [[TestManager alloc] init]; // Initialise and store the instance
	}
	return _sharedInstance; // Return the instance
}

-(bool)hasStarted
{
	for (Test *test in tests) {
		if ([test hasStarted]) return YES;
	}
	return NO;
}

-(NSString *)getProgress
{
	int numCompletedTests = 0;
	for (Test *test in tests) {
		if ([test isComplete]) numCompletedTests++;
	}
	return [NSString stringWithFormat:@"%i/%i tests completed", numCompletedTests, (int) [tests count]];
}

-(void)endTestAndStartNextWithNavController:(UINavigationController *)navController
{
	currentTestOrder++;
	Test *nextText = [tests objectAtIndex:currentTestOrder];
	[nextText launchWithNavigationController:navController];
}

-(NSString *)getCSVContentForInterview
{
	NSMutableString *csvString = [NSMutableString new];
	// Participant Details
	[csvString appendString:@"Participant Details\n"];
	[csvString appendString:@"Date, Participant Name/ID, Participant Date of Birth, Participant Hospital No. Or Address, Participant Age at Leaving Full Time Education, Patient Occupation, Patient Handedness\n"];
	[csvString appendFormat:@"%@,%@,%@,%@,%@,%@,%@\n",
	[self testDate], [self participantName], [self participantDateOfBirth], [self participantHospitalNoOrAddress], [self participantAgeLeavingEducation], [self participantOccupation], [self participantHandedness]];
	[csvString appendString:@"\n \n"];

	// Test Details
	[csvString appendString:@"Test Details\n"];
	[csvString appendString:@"Test Category, Test Name, Test Score, VFI\n"];
	for (Test *test in tests) {
		if ([test vfi])
			[csvString appendFormat:@"%@,%@,%d,%.2lf\n", [test categoryName], [test testName], [test score], [[test vfi] doubleValue]];
		else
			[csvString appendFormat:@"%@,%@,%d\n", [test categoryName], [test testName], [test score]];
	}
	[csvString appendString:@"\n \n"];

	// Category Details
	[csvString appendString:@"Category Details\n"];
	[csvString appendString:@"Category Name, Category Score\n"];
	for (NSString *cat in @[@"Language", @"Verbal Fluency", @"Executive", @"Memory", @"Visuospatial"]) {
		[csvString appendFormat:@"%@,%d\n", cat, [[self scoreForCategory:cat] integerValue]];
	}
	[csvString appendString:@"\n \n"];

	// ECAS total
	[csvString appendFormat:@"ECAS Score:, %d", [[self ecasScore] integerValue]];
	return csvString;
}

@end
