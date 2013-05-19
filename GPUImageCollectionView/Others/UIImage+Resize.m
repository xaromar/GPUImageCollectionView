//
//  UIImage+Resize.m
//  GPUImageCollectionView
//
//  Created by Xavi on 12/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithImage:(UIImage*)image scaleProportionalToSize:(CGSize)newSize
{
    float widthRatio = newSize.width/image.size.width;
    float heightRatio = newSize.height/image.size.height;
    
    if(widthRatio > heightRatio)
    {
        newSize=CGSizeMake(image.size.width*heightRatio,image.size.height*heightRatio);
    } else {
        newSize=CGSizeMake(image.size.width*widthRatio,image.size.height*widthRatio);
    }
    
    return [UIImage imageWithImage:image scaledToSize:newSize];
}

@end
