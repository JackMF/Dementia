//
//  Test.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "Test.h"
#import "PreTestViewController.h"
#import "PostTestViewController.h"
#import "TestViewController.h"


@implementation Test
@synthesize testViewController;
@synthesize testScore;
@synthesize order, className, categoryName, testName, preTestInstructions, postTestMessage, imageDictionaries,questions,story,buttonNames, toSpell, buttonText;

-(id)init
{
	self = [super init];
	if (self) {
		// Set our pre-test controller
		preTestViewController = [[PreTestViewController alloc] initWithNibName:@"PreTestViewController" bundle:nil];
		preTestViewController.test = self;
		// Set our post-test controller
		postTestViewController = [[PostTestViewController alloc] initWithNibName:@"PostTestViewController" bundle:nil];
		postTestViewController.test = self;
	}
	return self;
}

// Initialises the test using a dictionary from the property list
-(id)initWithPlistDict:(NSDictionary *)plistDict
{
	if (self = [self init]) {
		if (plistDict) {
			order = (int) [[plistDict valueForKey:@"order"] integerValue];
			className = [plistDict valueForKey:@"className"];
			categoryName = [plistDict valueForKey:@"categoryName"];
			testName = [plistDict valueForKey:@"testName"];
			preTestInstructions = [plistDict valueForKey:@"preTestInstructions"];
			postTestMessage = [plistDict valueForKey:@"postTestMessage"];

			if ([[plistDict allKeys] containsObject:@"imageDictionaries"]) imageDictionaries = [plistDict valueForKey:@"imageDictionaries"];

			if ([[plistDict allKeys] containsObject:@"questions"]) questions = [plistDict valueForKey:@"questions"];
			if ([[plistDict allKeys] containsObject:@"story"]) story = [plistDict valueForKey:@"story"];

			if ([[plistDict allKeys] containsObject:@"buttonNames"]) buttonNames = [plistDict valueForKey:@"buttonNames"];

			if ([[plistDict allKeys] containsObject:@"toSpell"]) toSpell = [plistDict valueForKey:@"toSpell"];
			if ([[plistDict allKeys] containsObject:@"buttonText"]) buttonText = [plistDict valueForKey:@"buttonText"];
            

			// Set our test controller
			testViewController = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
			if (!testViewController)
				return nil;
			[testViewController setTest:self];
		}
	}
	return self;
}

-(void)launchWithNavigationController:(UINavigationController *)navController
{
	navigationController = navController;       // Store reference to the navigation controller
	[self startPreTest];
}

-(void)startPreTest
{
	[navigationController pushViewController:preTestViewController animated:YES];
}

-(void)startTest
{
	[navigationController pushViewController:testViewController animated:YES];
}

-(void)startPostTest
{
	[navigationController pushViewController:postTestViewController animated:YES];
}

-(void)endTest
{
	[navigationController popToRootViewControllerAnimated:YES];
}

-(NSString *)getFullTestName
{
	return [NSString stringWithFormat:@"%@ - %@", categoryName, testName];
}

-(void)addToTestScore:(int)toAdd
{
	testScore+=toAdd;
	NSLog(@"Score: %i", testScore);      // Log the new score
}

@end
