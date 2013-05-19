//
//  FilterSettings.h
//  GPUImageCollectionView
//
//  Created by Xavi on 12/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterSettings : NSObject

@property (nonatomic, assign) BOOL hidden;
@property (nonatomic, assign) float value;
@property (nonatomic, assign) float minimumValue;
@property (nonatomic, assign) float maximumValue;

@end
