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
-(id)initWithTest:(TestViewController *)initTestViewController navigationController:(UINavigationController *)initNavController;
@property (nonatomic) int testScore;
@property (nonatomic) TestViewController *testViewController;
-(void)startPreTest;
-(void)startTest;
-(void)startPostTest;
-(void)endTest;
-(NSString *)getTestName;
@end
