//
//  PendingOperations.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "PendingOperations.h"

@implementation PendingOperations

@synthesize filtrationsInProgress = _filtrationsInProgress;
@synthesize filtrationQueue = _filtrationQueue;

- (NSMutableDictionary *)filtrationsInProgress {
    if (!_filtrationsInProgress) {
        _filtrationsInProgress = [[NSMutableDictionary alloc] init];
    }
    return _filtrationsInProgress;
}

- (NSOperationQueue *)filtrationQueue {
    if (!_filtrationQueue) {
        _filtrationQueue = [[NSOperationQueue alloc] init];
        _filtrationQueue.name = @"Image Filtration Queue";
        _filtrationQueue.maxConcurrentOperationCount = 1;
    }
    return _filtrationQueue;
}

@end
