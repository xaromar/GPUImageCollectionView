//
//  UIImage+Resize.h
//  GPUImageCollectionView
//
//  Created by Xavi on 12/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (UIImage *)imageWithImage:(UIImage*)image scaleProportionalToSize:(CGSize)newSize;

@end
