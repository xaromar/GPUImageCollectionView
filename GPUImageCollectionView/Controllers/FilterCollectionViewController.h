//
//  FilterCollectionViewController.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 8/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import "PendingOperations.h"
#import "ImageFiltrationOperation.h"

@interface FilterCollectionViewController : UIViewController <ImageFiltrationDelegate>

@property (nonatomic, strong) UIImage *sourceImage;
@property (nonatomic, strong) UIImage *rawSourceImage;

@property (nonatomic, strong) NSMutableArray *photosFiltered;
@property (nonatomic, strong) PendingOperations *pendingOperations;

@end
