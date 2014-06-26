//
//  TestManager.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Test;

@interface TestManager : NSObject
{
}

@property (nonatomic) NSArray *tests;

@property NSString *testDate;
@property NSString *participantName;
@property NSString *participantDateOfBirth;
@property NSString *participantHospitalNoOrAddress;
@property NSString *participantAgeLeavingEducation;
@property NSString *participantOccupation;
@property NSString *participantHandedness;
@property (readonly) bool hasStarted;

@property int currentTestOrder;

-(void)endTestAndStartNextWithNavController:(UINavigationController *)navController;

+(TestManager *)sharedInstance;
-(NSString *)scoreForTestWithIndex:(int)index;
-(NSString *)categoryScoreWithCategoryName:(NSString *)categoryName;
-(NSString *)ecasScore;
-(NSString *)getProgress;

@end
