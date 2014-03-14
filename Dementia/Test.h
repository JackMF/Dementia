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
}
-(id)initWithPreTest:(PreTestViewController *)pre test:(TestViewController *)test postTest:(PostTestViewController *)post navigationController:(UINavigationController *)navController;
@property (nonatomic) PreTestViewController *preTestViewController;
@property (nonatomic) TestViewController *testViewController;
@property (nonatomic) PostTestViewController *postTestViewController;
-(void)startPreTest;
-(void)startTest;
-(void)startPostTest;
-(void)endTest;

@end
