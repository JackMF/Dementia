//
//  ImageLoader.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageLoader : NSObject
{
    NSArray *testImages;
}
+(ImageLoader *)sharedInstance;
-(NSArray *)getTestImages;
@end
