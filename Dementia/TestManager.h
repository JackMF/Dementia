//
//  TestManager.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestManager : NSObject
@property (nonatomic) NSArray *tests;
+(TestManager *)sharedInstance;

@end
