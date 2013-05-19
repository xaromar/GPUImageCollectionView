//
//  UISlider+Tools.m
//  GPUImageCollectionView
//
//  Created by Xavi on 17/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "UISlider+Tools.h"

@implementation UISlider (Tools)

static const CGSize kKnobSize = (CGSize){.width = 24, .height = 24};
// This is the margin around kKnobSize which the shadow occupies.
static const CGFloat kShadowMargin = 1.0f;

-(void)setMetallicThumb
{
    // Create an image context big enough for the knob and shadow, and with the main screen's scale
    UIGraphicsBeginImageContextWithOptions(kKnobSize, NO, [[UIScreen mainScreen] scale]);
    
    // We don't need alpha for the image – we'll clip it later.
    // Create a colour space for us to draw the angular gradient.
    CGImageAlphaInfo alphaInfo = kCGImageAlphaNone;
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceGray();
    size_t components = CGColorSpaceGetNumberOfComponents(colourSpace);
    size_t bitsPerComponent = 8;
    size_t bytesPerComponent = bitsPerComponent / 8;
    size_t bytesPerRow = kKnobSize.width * bytesPerComponent * components;
    size_t dataLength = bytesPerRow * kKnobSize.height;
    
    uint8_t data[dataLength];
    
    // Create an image context within which we'll render the gradient.
    CGContextRef imageContext = CGBitmapContextCreate(&data, kKnobSize.width, kKnobSize.height, bitsPerComponent, bytesPerRow, colourSpace, alphaInfo);
    
    // This math is borrowed from http://stackoverflow.com/questions/6905466/cgcontextdrawanglegradient
    // Basically, for each pixel, it calculates the grey value of that pixel.
    NSUInteger offset = 0;
    for (NSUInteger y = 0; y < kKnobSize.height; ++y) {
        for (NSUInteger x = 0; x < bytesPerRow; x += components) {
            CGFloat opposite = y - kKnobSize.height/2.;
            CGFloat adjacent = x - kKnobSize.width/2.;
            if (adjacent == 0) adjacent = 0.001; // avoid division by zero
            CGFloat angle = atan(opposite/adjacent);
            // We want value to have a range from [1.5 ... 2.0].
            CGFloat value = 1.5f + 0.5f * cos(0);
            //data[offset] will have a range of [127 ... 255].
            data[offset] = abs(cos((angle * value)) * 128) + 127;
            
            CGFloat a = (opposite+0.5);
            CGFloat b = (adjacent+0.5);
            
            CGFloat distance = sqrtf(a*a + b*b);
            NSUInteger roundedDistance = lrintf(distance);
            
            if (roundedDistance % 2 == 0)
            {
                data[offset] -= 20 * fabsf(roundedDistance - distance);
            }
            
            offset += components * bytesPerComponent;
        }
    }
    
    // We'll create our image from the context, then release the context and colour space
    CGImageRef image = CGBitmapContextCreateImage(imageContext);
    CGContextRelease(imageContext);
    CGColorSpaceRelease(colourSpace);
    
    // Next, we'll grab the context into a local variable to do our clipping.
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Draw a shadow first, under the button.
    {
        CGContextSaveGState(context);
        
        CGRect shadowRect = (CGRect){.origin.x = kShadowMargin, .origin.y = kShadowMargin*2.0f, .size.width = kKnobSize.width - kShadowMargin*2.0, .size.height = kKnobSize.height - kShadowMargin*2.0f};
        CGContextAddEllipseInRect(context, shadowRect);
        CGContextClip(context);
        [[UIColor colorWithWhite:0.0f alpha:0.3f] set];
        CGContextFillRect(context, shadowRect);
        
        CGContextRestoreGState(context);
    }
    
    CGRect knobRect = (CGRect){.origin.x = kShadowMargin, .origin.y = kShadowMargin, .size.width = kKnobSize.width - kShadowMargin*2.0, .size.height = kKnobSize.height - kShadowMargin*2.0f};
    // Clip to a circle
    CGContextAddEllipseInRect(context, knobRect);
    CGContextClip(context);
    
    // Draw our CGImageRef into our context and then release it.
    CGContextDrawImage(context, knobRect, image);
    CGImageRelease(image);
    
    // Grab the image from our context and set it to our applicable control states.
    UIImage *knobImage = UIGraphicsGetImageFromCurrentImageContext();
    [self setThumbImage:knobImage forState:UIControlStateNormal];
    [self setThumbImage:knobImage forState:UIControlStateSelected];
    [self setThumbImage:knobImage forState:UIControlStateHighlighted];
    
    // End the image context we created at the very beginning of this method.
    UIGraphicsEndImageContext();
}

@end
