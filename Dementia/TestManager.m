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
    NSString *testsPlistPath = [[NSBundle mainBundle] pathForResource:@"Tests" ofType:@"plist"];
    // Load image database from file
    NSArray *loadedTestDicts = [NSArray arrayWithContentsOfFile:testsPlistPath];
    // Sort them by 'order'
    loadedTestDicts = [loadedTestDicts sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
    
    NSMutableArray *newTests = [[NSMutableArray alloc] init];
    for (NSDictionary *testDict in loadedTestDicts) {
        Test *newTest = [[Test alloc] initWithPlistDict:testDict];
        [newTests addObject:newTest];
    }
    tests = newTests;
}

+(TestManager *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[TestManager alloc] init];
    }
    return _sharedInstance;
}
@end
