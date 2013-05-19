//
//  Filter.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 12/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"
#import "FilterSettings.h"

@interface FilterInfo : NSObject

@property (nonatomic, strong) FilterSettings *filterSettingsSlider;
@property (nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property (nonatomic, copy) NSString *name;

@end
