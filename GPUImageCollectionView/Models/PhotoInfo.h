//
//  Photo.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"


@interface PhotoInfo : NSObject

@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, strong) NSString *filterName;
@property (nonatomic, getter = isFiltered) BOOL filtered;
//@property (nonatomic, strong) GPUImageFilter *filter;

@end
