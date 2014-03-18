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

-(id)init
{
    if (self = [super init]) {
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
        if (newTest){
            [newTests addObject:newTest];                              // Add the test to our newTests        }
        }
        else{
            NSLog(@"Test %@ fail to load test",[testDict valueForKey:@"testName"]);
        }
                  
    }
    tests = newTests;
}

// Returns a shared instance of the test manager
+(TestManager *)sharedInstance
{
    if (!_sharedInstance) { // If we don't have a shared instance
        _sharedInstance = [[TestManager alloc] init]; // Initialise and store the instance
    }
    return _sharedInstance; // Return the instance
}
@end
