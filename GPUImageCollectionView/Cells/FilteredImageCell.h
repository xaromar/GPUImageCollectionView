//
//  FilteredImageCell.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 8/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilteredImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageFiltered;
@property (weak, nonatomic) IBOutlet UILabel *filterName;

@end
