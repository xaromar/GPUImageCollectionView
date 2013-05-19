//
//  ImageFiltrationOperation.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "ImageFiltrationOperation.h"
#import "Filtrator.h"
#import "FilterInfo.h"


@interface ImageFiltrationOperation ()

@property (nonatomic, readwrite, strong) NSIndexPath *indexPathInCollectionView;
@property (nonatomic, readwrite, strong) PhotoInfo *photoInfo;
@end


@implementation ImageFiltrationOperation 

#pragma mark -
#pragma mark - Life cycle

- (id)initFilterForPhoto:(PhotoInfo *)photoInfo atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate
{
    
    if (self = [super init]) {
        self.photoInfo = photoInfo;
        self.indexPathInCollectionView = indexPath;
        self.delegate = theDelegate;
    }
    return self;
}


#pragma mark -
#pragma mark - Main operation


- (void)main {
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        if (self.photoInfo.isFiltered)
            return;
        
        Filtrator *filtrator = [[Filtrator alloc]initWithFilterType:self.indexPathInCollectionView.row];
        PhotoInfo *processedImage = [filtrator startFilterAndReturnPhotoInfoWithImage:self.photoInfo.photo];
        
        if (self.isCancelled)
            return;
        
        if (processedImage) {
            self.photoInfo.photo = processedImage.photo;
            self.photoInfo.filterName = processedImage.filterName;
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageFiltrationDidFinish:) withObject:self waitUntilDone:NO];
        }
    }
    
}

@end


