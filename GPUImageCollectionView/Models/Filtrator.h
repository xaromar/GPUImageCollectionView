//
//  Filtrator.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"
#import "FilterList.h"
#import "PhotoInfo.h"
#import "FilterInfo.h"
#import "FilterSettings.h"

@interface Filtrator : NSObject

- (id)initWithFilterType:(GPUImageShowcaseFilterType)newFilterType;
- (FilterInfo *)startFilter;
- (PhotoInfo *)startFilterAndReturnPhotoInfoWithImage:(UIImage *)image;
- (GPUImageOutput<GPUImageInput> *)updateFilterWithSliderValue:(float)value forFilter:(GPUImageOutput<GPUImageInput> *)filter;

@property (nonatomic, assign) GPUImageShowcaseFilterType filterType;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) FilterSettings *filterSettingsSlider;

@end
