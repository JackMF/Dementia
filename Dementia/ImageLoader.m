//
//  ImageLoader.m
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import "ImageLoader.h"

@implementation ImageLoader
static ImageLoader *_sharedInstance;

-(id)init
{
    if (self = [super init]) {
        [self loadTestImages];
    }
    return self;
}

// Loads the test image details from the plist file
-(void)loadTestImages
{
    NSString *imagesPlistPath = [[NSBundle mainBundle] pathForResource:@"Images" ofType:@"plist"];
    // Load image database from file
    NSArray *imagesDicts = [NSArray arrayWithContentsOfFile:imagesPlistPath];
    // Sort them by 'order'
    testImages = [imagesDicts sortedArrayUsingDescriptors:@[[[NSSortDescriptor alloc] initWithKey:@"order" ascending:YES]]];
}

-(NSArray *)getTestImages
{
    return testImages;
}

+(ImageLoader *)sharedInstance
{
    if (!_sharedInstance) {
        _sharedInstance = [[ImageLoader alloc] init];
    }
    return _sharedInstance;
}
@end
