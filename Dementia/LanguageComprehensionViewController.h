//
//  LanguageComprehensionViewController.h
//  Dementia
//
//  Created by Chris on 14/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LanguageComprehensionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    __weak IBOutlet UICollectionView *collectionView;
}

@end
