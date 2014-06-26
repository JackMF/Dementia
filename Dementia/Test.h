//
//  Test.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PreTestViewController, PostTestViewController, TestViewController;

@interface Test : NSObject
{
	UINavigationController *navigationController;
	PreTestViewController *preTestViewController;
	PostTestViewController *postTestViewController;
}

-(id)initWithPlistDict:(NSDictionary *)plistDict;
// Values loaded from property list
@property (nonatomic) int order;
@property (nonatomic) NSString *className;
@property (nonatomic) NSString *categoryName;
@property (nonatomic) NSString *testName;
@property (nonatomic) NSString *preTestInstructions;
@property (nonatomic) NSString *postTestMessage;
@property (nonatomic) NSArray *imageDictionaries;
@property (nonatomic) NSArray *questions;
@property (nonatomic) NSString *story;
@property (nonatomic) NSArray *buttonNames;
@property (nonatomic) NSArray *buttonText;

@property (nonatomic) int score;
@property (nonatomic) int maxScore;
@property (nonatomic) bool hasStarted;
@property (nonatomic) bool isComplete;
@property (nonatomic) TestViewController *testViewController;

@property (nonatomic) NSNumber *vfi;

-(void)launchWithNavigationController:(UINavigationController *)navController;
-(void)startPreTest;
-(void)startTest;
-(void)startPostTest;
-(void)endTest:(bool)isAnimated;
-(void)addToTestScore:(int)toAdd;
-(NSString *)getFullTestName;
@end
