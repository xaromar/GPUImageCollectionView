//
//  PendingOperations.h
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface PendingOperations : NSObject

@property (nonatomic, strong) NSMutableDictionary *filtrationsInProgress;
@property (nonatomic, strong) NSOperationQueue *filtrationQueue;

@end