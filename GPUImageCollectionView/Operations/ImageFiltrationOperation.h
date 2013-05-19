//
//  ImageFiltrationOperation.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "PhotoInfo.h"

@protocol ImageFiltrationDelegate;

@interface ImageFiltrationOperation : NSOperation

@property (nonatomic, weak) id <ImageFiltrationDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInCollectionView;
@property (nonatomic, readonly, strong) PhotoInfo *photoInfo;

- (id)initFilterForPhoto:(PhotoInfo *)photoInfo atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate;

@end

@protocol ImageFiltrationDelegate <NSObject>
- (void)imageFiltrationDidFinish:(ImageFiltrationOperation *)filtration;
@end