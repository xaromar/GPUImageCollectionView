//
//  FilterDetailsViewController.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"

@interface FilterDetailsViewController : UIViewController

@property (nonatomic, strong)UIImage *rawImage;
@property (nonatomic, assign)NSUInteger filterType;

@property (weak, nonatomic) IBOutlet GPUImageView *imageToShow;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end
