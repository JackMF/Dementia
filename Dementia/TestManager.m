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
		for (Test *test in tests) {
			if ([[test categoryName] isEqualToString:@"Language"] ||
			    [[test categoryName] isEqualToString:@"Verbal Fluency"] ||
			    [[test categoryName] isEqualToString:@"Executive"]) {
				if (![test isComplete]) return nil;
				categoryTotal += [test score];
				maxTotal += [test maxScore];
			}
		}
		return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
	} else if ([categoryName isEqualToString:@"alsNonSpecific"]) {
		for (Test *test in tests) {
			if ([[test categoryName] isEqualToString:@"Memory"] ||
			    [[test categoryName] isEqualToString:@"Visuospatial"]) {
				if (![test isComplete]) return nil;
				categoryTotal += [test score];
				maxTotal += [test maxScore];
			}
		}
		return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
	}

	for (Test *test in tests) {
		if ([[test categoryName] isEqualToString:categoryName]) {
			if (![test isComplete]) return nil;
			categoryTotal += [test score];
			maxTotal += [test maxScore];
		}
	}
	return [NSString stringWithFormat:@"%i/%i", categoryTotal, maxTotal];
}


-(NSString *)ecasScore
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

-(void)endTestAndStartNextWithNavController:(UINavigationController *)navController
{
	currentTestOrder++;
	Test *nextText = [tests objectAtIndex:currentTestOrder];
	[nextText launchWithNavigationController:navController];
}

@end
