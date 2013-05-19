//
//  Filter.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 12/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "FilterInfo.h"

@implementation FilterInfo

-(id)init{
    self = [super init];
    if(self){
        _filterSettingsSlider = [[FilterSettings alloc]init];
    }
    return self;
}

@end
