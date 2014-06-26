//
//  ButtonListViewController.h
//  Dementia
//
//  Created by Chris on 22/03/2014.
//  Copyright (c) 2014 chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
	__weak IBOutlet UICollectionView *listCollectionView;

}
@property (nonatomic, setter = setButtonValues :) NSArray *buttonLabelValues;
@property (nonatomic) BOOL oneItemPerRow;
-(NSInteger)getNumberOfCorrectAnswers;
-(void)setButtonValues:(NSArray *)newButtonValues;
@end
