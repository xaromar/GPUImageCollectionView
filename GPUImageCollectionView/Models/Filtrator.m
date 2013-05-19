//
//  Filtrator.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "Filtrator.h"

@implementation Filtrator


- (id)initWithFilterType:(GPUImageShowcaseFilterType)newFilterType;
{
    self = [super init];
    if (self)
    {
        _filterType = newFilterType;
        //_filterType = (newFilterType % 10) + 20;
        //_filterType = GPUIMAGE_CROSSHATCH +1;
        _filterSettingsSlider = [[FilterSettings alloc]init];
    }
    return self;
}

- (PhotoInfo *)startFilterAndReturnPhotoInfoWithImage:(UIImage *)image
{
    PhotoInfo *photoInfo = [[PhotoInfo alloc]init];
    FilterInfo *filterInfo = [self startFilter];
    photoInfo.photo = [filterInfo.filter imageByFilteringImage:image];
    photoInfo.filterName = filterInfo.name;
    
    return photoInfo;
}


- (FilterInfo *)startFilter
{
    GPUImageOutput<GPUImageInput> *filter;

    switch (self.filterType)
    {
        case GPUIMAGE_SEPIA:
        {
            self.title = @"Sepia Tone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            filter = [[GPUImageSepiaFilter alloc] init];
        }; break;
        case GPUIMAGE_PIXELLATE:
        {
            self.title = @"Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            filter = [[GPUImagePixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_POLARPIXELLATE:
        {
            self.title = @"Polar Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:-0.1];
            [self.filterSettingsSlider setMaximumValue:0.1];
            
            filter = [[GPUImagePolarPixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_PIXELLATE_POSITION:
        {
            self.title = @"Pixellate (position)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.25];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.5];
            
            filter = [[GPUImagePixellatePositionFilter alloc] init];
        }; break;
        case GPUIMAGE_POLKADOT:
        {
            self.title = @"Polka Dot";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            filter = [[GPUImagePolkaDotFilter alloc] init];
        }; break;
        case GPUIMAGE_HALFTONE:
        {
            self.title = @"Halftone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.01];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.05];
            
            filter = [[GPUImageHalftoneFilter alloc] init];
        }; break;
        case GPUIMAGE_CROSSHATCH:
        {
            self.title = @"Crosshatch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.03];
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.06];
            
            filter = [[GPUImageCrosshatchFilter alloc] init];
        }; break;
        case GPUIMAGE_COLORINVERT:
        {
            self.title = @"Color Invert";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageColorInvertFilter alloc] init];
        }; break;
        case GPUIMAGE_GRAYSCALE:
        {
            self.title = @"Grayscale";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageGrayscaleFilter alloc] init];
        }; break;
        case GPUIMAGE_MONOCHROME:
        {
            self.title = @"Monochrome";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            filter = [[GPUImageMonochromeFilter alloc] init];
            [(GPUImageMonochromeFilter *)filter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
        }; break;
        case GPUIMAGE_FALSECOLOR:
        {
            self.title = @"False Color";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageFalseColorFilter alloc] init];
		}; break;
        case GPUIMAGE_SOFTELEGANCE:
        {
            self.title = @"Soft Elegance (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageSoftEleganceFilter alloc] init];
        }; break;
        case GPUIMAGE_MISSETIKATE:
        {
            self.title = @"Miss Etikate (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageMissEtikateFilter alloc] init];
        }; break;
        case GPUIMAGE_AMATORKA:
        {
            self.title = @"Amatorka (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageAmatorkaFilter alloc] init];
        }; break;
            
        case GPUIMAGE_SATURATION:
        {
            self.title = @"Saturation";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:2.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            
            filter = [[GPUImageSaturationFilter alloc] init];
            [(GPUImageSaturationFilter *)filter setSaturation:2.0];
        }; break;
        case GPUIMAGE_CONTRAST:
        {
            self.title = @"Contrast";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:3.0];
            
            filter = [[GPUImageContrastFilter alloc] init];
            [(GPUImageContrastFilter *)filter setContrast:3.0];
        }; break;
        case GPUIMAGE_BRIGHTNESS:
        {
            self.title = @"Brightness";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.6];
            
            filter = [[GPUImageBrightnessFilter alloc] init];
            [(GPUImageBrightnessFilter *)filter setBrightness:0.6];
        }; break;
        case GPUIMAGE_LEVELS:
        {
            self.title = @"Levels";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.7];
            
            filter = [[GPUImageLevelsFilter alloc] init];
            [(GPUImageLevelsFilter *)filter setRedMin:0.7 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setGreenMin:0.7 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setBlueMin:0.7 gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
        }; break;
        case GPUIMAGE_RGB:
        {
            self.title = @"RGB";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageRGBFilter alloc] init];
        }; break;
        case GPUIMAGE_HUE:
        {
            self.title = @"Hue";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:360.0];
            [self.filterSettingsSlider setValue:90.0];
            
            filter = [[GPUImageHueFilter alloc] init];
        }; break;
        case GPUIMAGE_WHITEBALANCE: //TEXTURE
        {
            self.title = @"White Balance";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:2500.0];
            [self.filterSettingsSlider setMaximumValue:7500.0];
            [self.filterSettingsSlider setValue:5000.0];
            
            filter = [[GPUImageWhiteBalanceFilter alloc] init];
        }; break;
        case GPUIMAGE_EXPOSURE:
        {
            self.title = @"Exposure";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-4.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:0.0];
            
            filter = [[GPUImageExposureFilter alloc] init];
        }; break;
        case GPUIMAGE_SHARPEN:
        {
            self.title = @"Sharpen";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:0.0];
            
            filter = [[GPUImageSharpenFilter alloc] init];
        }; break;
        case GPUIMAGE_UNSHARPMASK:
        {
            self.title = @"Unsharp Mask";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageUnsharpMaskFilter alloc] init];
            
            //            [(GPUImageUnsharpMaskFilter *)filter setIntensity:3.0];
        }; break;
        case GPUIMAGE_GAMMA:
        {
            self.title = @"Gamma";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:3.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageGammaFilter alloc] init];
        }; break;
        case GPUIMAGE_TONECURVE:
        {
            self.title = @"Tone curve";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageToneCurveFilter alloc] init];
            [(GPUImageToneCurveFilter *)filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
        }; break;
        case GPUIMAGE_HIGHLIGHTSHADOW:
        {
            self.title = @"Highlights and Shadows";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            filter = [[GPUImageHighlightShadowFilter alloc] init];
        }; break;
		case GPUIMAGE_HAZE:
        {
            self.title = @"Haze / UV";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-0.2];
            [self.filterSettingsSlider setMaximumValue:0.2];
            [self.filterSettingsSlider setValue:0.2];
            
            filter = [[GPUImageHazeFilter alloc] init];
        }; break;
//		case GPUIMAGE_AVERAGECOLOR: //iPad 2 crash
//        {
//            self.title = @"Average Color";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageAverageColor alloc] init];
//        }; break;
//		case GPUIMAGE_LUMINOSITY: //iPad 2 crash
//        {
//            self.title = @"Luminosity";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageLuminosity alloc] init];
//        }; break;
		case GPUIMAGE_HISTOGRAM:
        {
            self.title = @"Histogram";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:4.0];
            [self.filterSettingsSlider setMaximumValue:32.0];
            [self.filterSettingsSlider setValue:16.0];
            
            filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
        }; break;
		case GPUIMAGE_THRESHOLD:
        {
            self.title = @"Luminance Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageLuminanceThresholdFilter alloc] init];
        }; break;
		case GPUIMAGE_ADAPTIVETHRESHOLD:
        {
            self.title = @"Adaptive Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:20.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
        }; break;
		case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
        {
            self.title = @"Avg. Lum. Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
        }; break;
        case GPUIMAGE_CROP:
        {
            self.title = @"Crop";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
        }; break;
//		case GPUIMAGE_MASK: //needsSecondImage
//		{
//            self.title = @"Mask";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageMaskFilter alloc] init];
//			
//			[(GPUImageFilter*)filter setBackgroundColorRed:0.0 green:1.0 blue:0.0 alpha:1.0];
//        }; break;
        case GPUIMAGE_TRANSFORM:
        {
            self.title = @"Transform (2-D)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:6.28];
            [self.filterSettingsSlider setValue:2.0];
            
            filter = [[GPUImageTransformFilter alloc] init];
            [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
            //            [(GPUImageTransformFilter *)filter setIgnoreAspectRatio:YES];
        }; break;
        case GPUIMAGE_TRANSFORM3D:
        {
            self.title = @"Transform (3-D)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:6.28];
            [self.filterSettingsSlider setValue:0.75];
            
            filter = [[GPUImageTransformFilter alloc] init];
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.75, 0.0, 1.0, 0.0);
            
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
		}; break;
        case GPUIMAGE_SOBELEDGEDETECTION:
        {
            self.title = @"Sobel Edge Detection";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_XYGRADIENT:
        {
            self.title = @"XY Derivative";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageXYDerivativeFilter alloc] init];
        }; break;
//        case GPUIMAGE_HARRISCORNERDETECTION: //Logs Processing time, comment for now 
//        {
//            self.title = @"Harris Corner Detection";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.01];
//            [self.filterSettingsSlider setMaximumValue:0.70];
//            [self.filterSettingsSlider setValue:0.20];
//            
//            filter = [[GPUImageHarrisCornerDetectionFilter alloc] init];
//            [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:0.20];
//        }; break;
//        case GPUIMAGE_NOBLECORNERDETECTION: //Logs Processing time, comment for now
//        {
//            self.title = @"Noble Corner Detection";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.01];
//            [self.filterSettingsSlider setMaximumValue:0.70];
//            [self.filterSettingsSlider setValue:0.20];
//            
//            filter = [[GPUImageNobleCornerDetectionFilter alloc] init];
//            [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:0.20];
//        }; break;
//        case GPUIMAGE_SHITOMASIFEATUREDETECTION: //Logs Processing time, comment for now
//        {
//            self.title = @"Shi-Tomasi Feature Detection";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.01];
//            [self.filterSettingsSlider setMaximumValue:0.70];
//            [self.filterSettingsSlider setValue:0.20];
//            
//            filter = [[GPUImageShiTomasiFeatureDetectionFilter alloc] init];
//            [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:0.20];
//        }; break;
        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
        {
            self.title = @"Line Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.6];
            
            filter = [[GPUImageHoughTransformLineDetector alloc] init];
            [(GPUImageHoughTransformLineDetector *)filter setLineDetectionThreshold:0.60];
        }; break;
            
        case GPUIMAGE_PREWITTEDGEDETECTION:
        {
            self.title = @"Prewitt Edge Detection";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_CANNYEDGEDETECTION:
        {
            self.title = @"Canny Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:1.0];
            
            //            [self.filterSettingsSlider setMinimumValue:0.0];
            //            [self.filterSettingsSlider setMaximumValue:0.5];
            //            [self.filterSettingsSlider setValue:0.1];
            
            filter = [[GPUImageCannyEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_THRESHOLDEDGEDETECTION:
        {
            self.title = @"Threshold Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageThresholdEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_LOCALBINARYPATTERN:
        {
            self.title = @"Local Binary Pattern";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageLocalBinaryPatternFilter alloc] init];
        }; break;
//        case GPUIMAGE_BUFFER: //iPad 2 crash
//        {
//            self.title = @"Image Buffer";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageBuffer alloc] init];
//        }; break;
//        case GPUIMAGE_LOWPASS: //iPad 2 crash
//        {
//            self.title = @"Low Pass";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.5];
//            
//            filter = [[GPUImageLowPassFilter alloc] init];
//        }; break;
//        case GPUIMAGE_HIGHPASS://iPad 2 crash
//        {
//            self.title = @"High Pass";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.5];
//            
//            filter = [[GPUImageHighPassFilter alloc] init];
//        }; break;
//        case GPUIMAGE_MOTIONDETECTOR: //camera required
//        {
//            [videoCamera rotateCamera];
//            
//            self.title = @"Motion Detector";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.5];
//            
//            filter = [[GPUImageMotionDetector alloc] init];
//        }; break;
        case GPUIMAGE_SKETCH:
        {
            self.title = @"Sketch";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_THRESHOLDSKETCH:
        {
            self.title = @"Threshold Sketch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.9];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.9];
            
            filter = [[GPUImageThresholdSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_TOON:
        {
            self.title = @"Toon";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageToonFilter alloc] init];
        }; break;
        case GPUIMAGE_SMOOTHTOON:
        {
            self.title = @"Smooth Toon";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageSmoothToonFilter alloc] init];
        }; break;
        case GPUIMAGE_TILTSHIFT:
        {
            self.title = @"Tilt Shift";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:0.8];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageTiltShiftFilter alloc] init];
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:0.4];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:0.6];
            [(GPUImageTiltShiftFilter *)filter setFocusFallOffRate:0.2];
        }; break;
        case GPUIMAGE_CGA:
        {
            self.title = @"CGA Colorspace";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageCGAColorspaceFilter alloc] init];
        }; break;
        case GPUIMAGE_CONVOLUTION:
        {
            self.title = @"3x3 Convolution";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImage3x3ConvolutionFilter alloc] init];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {-2.0f, -1.0f, 0.0f},
            //                {-1.0f,  1.0f, 1.0f},
            //                { 0.0f,  1.0f, 2.0f}
            //            }];
            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
                {-1.0f,  0.0f, 1.0f},
                {-2.0f, 0.0f, 2.0f},
                {-1.0f,  0.0f, 1.0f}
            }];
            
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {1.0f,  1.0f, 1.0f},
            //                {1.0f, -8.0f, 1.0f},
            //                {1.0f,  1.0f, 1.0f}
            //            }];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f}
            //            }];
        }; break;
        case GPUIMAGE_EMBOSS:
        {
            self.title = @"Emboss";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageEmbossFilter alloc] init];
        }; break;
//        case GPUIMAGE_LAPLACIAN:
//        {
//            self.title = @"Laplacian";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageLaplacianFilter alloc] init];
//        }; break;
        case GPUIMAGE_POSTERIZE:
        {
            self.title = @"Posterize";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:20.0];
            [self.filterSettingsSlider setValue:10.0];
            
            filter = [[GPUImagePosterizeFilter alloc] init];
        }; break;
        case GPUIMAGE_SWIRL:
        {
            self.title = @"Swirl";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageSwirlFilter alloc] init];
        }; break;
        case GPUIMAGE_BULGE:
        {
            self.title = @"Bulge";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImageBulgeDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_SPHEREREFRACTION:
        {
            self.title = @"Sphere Refraction";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            filter = [[GPUImageSphereRefractionFilter alloc] init];
            [(GPUImageSphereRefractionFilter *)filter setRadius:0.15];
        }; break;
        case GPUIMAGE_GLASSSPHERE:
        {
            self.title = @"Glass Sphere";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            filter = [[GPUImageGlassSphereFilter alloc] init];
            [(GPUImageGlassSphereFilter *)filter setRadius:0.15];
        }; break;
        case GPUIMAGE_PINCH:
        {
            self.title = @"Pinch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-2.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:0.5];
            
            filter = [[GPUImagePinchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_STRETCH:
        {
            self.title = @"Stretch";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageStretchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_DILATION:
        {
            self.title = @"Dilation";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBDilationFilter alloc] initWithRadius:4];
		}; break;
        case GPUIMAGE_EROSION:
        {
            self.title = @"Erosion";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBErosionFilter alloc] initWithRadius:4];
		}; break;
        case GPUIMAGE_OPENING:
        {
            self.title = @"Opening";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBOpeningFilter alloc] initWithRadius:4];
		}; break;
        case GPUIMAGE_CLOSING:
        {
            self.title = @"Closing";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageRGBClosingFilter alloc] initWithRadius:4];
		}; break;
            
        case GPUIMAGE_PERLINNOISE:
        {
            self.title = @"Perlin Noise";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:30.0];
            [self.filterSettingsSlider setValue:8.0];
            
            filter = [[GPUImagePerlinNoiseFilter alloc] init];
        }; break;
//        case GPUIMAGE_VORONOI:
//        {
//            self.title = @"Voronoi";
//            self.filterSettingsSlider.hidden = YES;
//            
//            GPUImageJFAVoronoiFilter *jfa = [[GPUImageJFAVoronoiFilter alloc] init];
//            [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
//            
//            sourcePicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"voroni_points2.png"]];
//            
//            [sourcePicture addTarget:jfa];
//            
//            filter = [[GPUImageVoronoiConsumerFilter alloc] init];
//            
//            [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
//            [(GPUImageVoronoiConsumerFilter *)filter setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
//            
//            [videoCamera addTarget:filter];
//            [jfa addTarget:filter];
//            [sourcePicture processImage];
//        }; break;
        case GPUIMAGE_MOSAIC:
        {
            self.title = @"Mosaic";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.002];
            [self.filterSettingsSlider setMaximumValue:0.05];
            [self.filterSettingsSlider setValue:0.025];
            
            filter = [[GPUImageMosaicFilter alloc] init];
            [(GPUImageMosaicFilter *)filter setTileSet:@"squares.png"];
            [(GPUImageMosaicFilter *)filter setColorOn:NO];
            //[(GPUImageMosaicFilter *)filter setTileSet:@"dotletterstiles.png"];
            //[(GPUImageMosaicFilter *)filter setTileSet:@"curvies.png"];
            
            [filter setInputRotation:kGPUImageRotateRight atIndex:0];
            
        }; break;
//        case GPUIMAGE_CHROMAKEY: //needsSecondImage
//        {
//            self.title = @"Chroma Key (Green)";
//            self.filterSettingsSlider.hidden = NO;
//            needsSecondImage = YES;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.4];
//            
//            filter = [[GPUImageChromaKeyBlendFilter alloc] init];
//            [(GPUImageChromaKeyBlendFilter *)filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
//        }; break;
//        case GPUIMAGE_CHROMAKEYNONBLEND: //needsSecondImage
//        {
//            self.title = @"Chroma Key (Green)";
//            self.filterSettingsSlider.hidden = NO;
//            needsSecondImage = YES;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.4];
//            
//            filter = [[GPUImageChromaKeyFilter alloc] init];
//            [(GPUImageChromaKeyFilter *)filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
//        }; break;
//        case GPUIMAGE_ADD: //needsSecondImage
//        {
//            self.title = @"Add Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageAddBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_DIVIDE: //needsSecondImage
//        {
//            self.title = @"Divide Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageDivideBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_MULTIPLY: //needsSecondImage
//        {
//            self.title = @"Multiply Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageMultiplyBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_OVERLAY: //needsSecondImage
//        {
//            self.title = @"Overlay Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageOverlayBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_LIGHTEN: //needsSecondImage
//        {
//            self.title = @"Lighten Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageLightenBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_DARKEN: //needsSecondImage
//        {
//            self.title = @"Darken Blend";
//            self.filterSettingsSlider.hidden = YES;
//            
//            needsSecondImage = YES;
//            filter = [[GPUImageDarkenBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_DISSOLVE: //needsSecondImage
//        {
//            self.title = @"Dissolve Blend";
//            self.filterSettingsSlider.hidden = NO;
//            needsSecondImage = YES;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.5];
//            
//            filter = [[GPUImageDissolveBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_SCREENBLEND: //needsSecondImage
//        {
//            self.title = @"Screen Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageScreenBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_COLORBURN: //needsSecondImage
//        {
//            self.title = @"Color Burn Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageColorBurnBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_COLORDODGE: //needsSecondImage
//        {
//            self.title = @"Color Dodge Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageColorDodgeBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_LINEARBURN: //needsSecondImage
//        {
//            self.title = @"Linear Burn Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageLinearBurnBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_EXCLUSIONBLEND:
//        {
//            self.title = @"Exclusion Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageExclusionBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_DIFFERENCEBLEND: //needsSecondImage
//        {
//            self.title = @"Difference Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageDifferenceBlendFilter alloc] init];
//        }; break;
//		case GPUIMAGE_SUBTRACTBLEND: //needsSecondImage
//        {
//            self.title = @"Subtract Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageSubtractBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_HARDLIGHTBLEND: //needsSecondImage
//        {
//            self.title = @"Hard Light Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageHardLightBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_SOFTLIGHTBLEND: //needsSecondImage
//        {
//            self.title = @"Soft Light Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageSoftLightBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_COLORBLEND: //needsSecondImage
//        {
//            self.title = @"Color Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageColorBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_HUEBLEND: //needsSecondImage
//        {
//            self.title = @"Hue Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageHueBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_SATURATIONBLEND: //needsSecondImage
//        {
//            self.title = @"Saturation Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageSaturationBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_LUMINOSITYBLEND: //needsSecondImage
//        {
//            self.title = @"Luminosity Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageLuminosityBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_NORMALBLEND: //needsSecondImage
//        {
//            self.title = @"Normal Blend";
//            self.filterSettingsSlider.hidden = YES;
//            needsSecondImage = YES;
//            
//            filter = [[GPUImageNormalBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_POISSONBLEND: //needsSecondImage
//        {
//            self.title = @"Poisson Blend";
//            self.filterSettingsSlider.hidden = NO;
//            needsSecondImage = YES;
//            
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            [self.filterSettingsSlider setValue:0.5];
//            
//            filter = [[GPUImagePoissonBlendFilter alloc] init];
//        }; break;
//        case GPUIMAGE_OPACITY: //needsSecondImage
//        {
//            self.title = @"Opacity Adjustment";
//            self.filterSettingsSlider.hidden = NO;
//            needsSecondImage = YES;
//            
//            [self.filterSettingsSlider setValue:1.0];
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:1.0];
//            
//            filter = [[GPUImageOpacityFilter alloc] init];
//        }; break;
//        case GPUIMAGE_CUSTOM: //needs shader file
//        {
//            self.title = @"Custom";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomFilter"];
//        }; break;
        case GPUIMAGE_KUWAHARA:
        {
            self.title = @"Kuwahara";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:3.0];
            [self.filterSettingsSlider setMaximumValue:8.0];
            [self.filterSettingsSlider setValue:3.0];
            
            filter = [[GPUImageKuwaharaFilter alloc] init];
        }; break;
        case GPUIMAGE_KUWAHARARADIUS3:
        {
            self.title = @"Kuwahara (Radius 3)";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageKuwaharaRadius3Filter alloc] init];
        }; break;
        case GPUIMAGE_VIGNETTE:
        {
            self.title = @"Vignette";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.5];
            [self.filterSettingsSlider setMaximumValue:0.9];
            [self.filterSettingsSlider setValue:0.75];
            
            filter = [[GPUImageVignetteFilter alloc] init];
        }; break;
        case GPUIMAGE_GAUSSIAN:
        {
            self.title = @"Gaussian Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageGaussianBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_FASTBLUR:
        {
            self.title = @"Fast Blur";
            self.filterSettingsSlider.hidden = NO;
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageFastBlurFilter alloc] init];
		}; break;
        case GPUIMAGE_BOXBLUR:
        {
            self.title = @"Box Blur";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageBoxBlurFilter alloc] init];
		}; break;
        case GPUIMAGE_MEDIAN:
        {
            self.title = @"Median";
            self.filterSettingsSlider.hidden = YES;
            
            filter = [[GPUImageMedianFilter alloc] init];
		}; break;
        case GPUIMAGE_MOTIONBLUR:
        {
            self.title = @"Motion Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:180.0f];
            [self.filterSettingsSlider setValue:0.0];
            
            filter = [[GPUImageMotionBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_ZOOMBLUR:
        {
            self.title = @"Zoom Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.5f];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageZoomBlurFilter alloc] init];
        }; break;
//        case GPUIMAGE_UIELEMENT:  //just sepia filter
//        {
//            self.title = @"UI Element";
//            self.filterSettingsSlider.hidden = YES;
//            
//            filter = [[GPUImageSepiaFilter alloc] init];
//		}; break;
        case GPUIMAGE_GAUSSIAN_SELECTIVE:
        {
            self.title = @"Selective Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:.75f];
            [self.filterSettingsSlider setValue:40.0/320.0];
            
            filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
            [(GPUImageGaussianSelectiveBlurFilter*)filter setExcludeCircleRadius:40.0/320.0];
        }; break;
        case GPUIMAGE_GAUSSIAN_POSITION:
        {
            self.title = @"Selective Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:.75f];
            [self.filterSettingsSlider setValue:40.0/320.0];
            
            filter = [[GPUImageGaussianBlurPositionFilter alloc] init];
            [(GPUImageGaussianBlurPositionFilter*)filter setBlurRadius:40.0/320.0];
        }; break;
        case GPUIMAGE_BILATERAL:
        {
            self.title = @"Bilateral Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            filter = [[GPUImageBilateralFilter alloc] init];
        }; break;
//        case GPUIMAGE_FILTERGROUP:  //group, comment for now
//        {
//            self.title = @"Filter Group";
//            self.filterSettingsSlider.hidden = NO;
//            
//            [self.filterSettingsSlider setValue:0.05];
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:0.3];
//            
//            filter = [[GPUImageFilterGroup alloc] init];
//            
//            GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
//            [(GPUImageFilterGroup *)filter addFilter:sepiaFilter];
//            
//            GPUImagePixellateFilter *pixellateFilter = [[GPUImagePixellateFilter alloc] init];
//            [(GPUImageFilterGroup *)filter addFilter:pixellateFilter];
//            
//            [sepiaFilter addTarget:pixellateFilter];
//            [(GPUImageFilterGroup *)filter setInitialFilters:[NSArray arrayWithObject:sepiaFilter]];
//            [(GPUImageFilterGroup *)filter setTerminalFilter:pixellateFilter];
//        }; break;
            
//        case GPUIMAGE_FACES: //faces detection, camera
//        {
//            facesSwitch.hidden = NO;
//            facesLabel.hidden = NO;
//            
//            [videoCamera rotateCamera];
//            self.title = @"Face Detection";
//            self.filterSettingsSlider.hidden = YES;
//            
//            [self.filterSettingsSlider setValue:1.0];
//            [self.filterSettingsSlider setMinimumValue:0.0];
//            [self.filterSettingsSlider setMaximumValue:2.0];
//            
//            filter = [[GPUImageSaturationFilter alloc] init];
//            [videoCamera setDelegate:self];
//            break;
//        }
            
        default: {
            self.title = @"Default";
            filter = [[GPUImageSepiaFilter alloc] init];
        };break;
    }
    
    FilterInfo *outputFilter = [[FilterInfo alloc]init];
    outputFilter.filter = filter;
    outputFilter.name = self.title;
    
    outputFilter.filterSettingsSlider.hidden = self.filterSettingsSlider.hidden;
    outputFilter.filterSettingsSlider.value = self.filterSettingsSlider.value;
    outputFilter.filterSettingsSlider.minimumValue = self.filterSettingsSlider.minimumValue;
    outputFilter.filterSettingsSlider.maximumValue = self.filterSettingsSlider.maximumValue;
    
    return outputFilter;
}

#pragma mark -
#pragma mark Filter adjustments

- (GPUImageOutput<GPUImageInput> *)updateFilterWithSliderValue:(float)value forFilter:(GPUImageOutput<GPUImageInput> *)filter
{
    switch(self.filterType)
    {
        case GPUIMAGE_SEPIA: [(GPUImageSepiaFilter *)filter setIntensity:value]; break;
        case GPUIMAGE_PIXELLATE: [(GPUImagePixellateFilter *)filter setFractionalWidthOfAPixel:value]; break;
        case GPUIMAGE_POLARPIXELLATE: [(GPUImagePolarPixellateFilter *)filter setPixelSize:CGSizeMake(value, value)]; break;
        case GPUIMAGE_PIXELLATE_POSITION: [(GPUImagePixellatePositionFilter *)filter setRadius:value]; break;
        case GPUIMAGE_POLKADOT: [(GPUImagePolkaDotFilter *)filter setFractionalWidthOfAPixel:value]; break;
        case GPUIMAGE_HALFTONE: [(GPUImageHalftoneFilter *)filter setFractionalWidthOfAPixel:value]; break;
        case GPUIMAGE_SATURATION: [(GPUImageSaturationFilter *)filter setSaturation:value]; break;
        case GPUIMAGE_CONTRAST: [(GPUImageContrastFilter *)filter setContrast:value]; break;
        case GPUIMAGE_BRIGHTNESS: [(GPUImageBrightnessFilter *)filter setBrightness:value]; break;
        case GPUIMAGE_LEVELS: {
            //float value = value;
            [(GPUImageLevelsFilter *)filter setRedMin:value gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setGreenMin:value gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
            [(GPUImageLevelsFilter *)filter setBlueMin:value gamma:1.0 max:1.0 minOut:0.0 maxOut:1.0];
        }; break;
        case GPUIMAGE_EXPOSURE: [(GPUImageExposureFilter *)filter setExposure:value]; break;
        case GPUIMAGE_MONOCHROME: [(GPUImageMonochromeFilter *)filter setIntensity:value]; break;
        case GPUIMAGE_RGB: [(GPUImageRGBFilter *)filter setGreen:value]; break;
        case GPUIMAGE_HUE: [(GPUImageHueFilter *)filter setHue:value]; break;
        case GPUIMAGE_WHITEBALANCE: [(GPUImageWhiteBalanceFilter *)filter setTemperature:value]; break;
        case GPUIMAGE_SHARPEN: [(GPUImageSharpenFilter *)filter setSharpness:value]; break;
        case GPUIMAGE_HISTOGRAM: [(GPUImageHistogramFilter *)filter setDownsamplingFactor:round(value)]; break;
        case GPUIMAGE_UNSHARPMASK: [(GPUImageUnsharpMaskFilter *)filter setIntensity:value]; break;
            //        case GPUIMAGE_UNSHARPMASK: [(GPUImageUnsharpMaskFilter *)filter setBlurSize:value]; break;
        case GPUIMAGE_GAMMA: [(GPUImageGammaFilter *)filter setGamma:value]; break;
        case GPUIMAGE_CROSSHATCH: [(GPUImageCrosshatchFilter *)filter setCrossHatchSpacing:value]; break;
        case GPUIMAGE_POSTERIZE: [(GPUImagePosterizeFilter *)filter setColorLevels:round(value)]; break;
        case GPUIMAGE_HAZE: [(GPUImageHazeFilter *)filter setDistance:value]; break;
        case GPUIMAGE_THRESHOLD: [(GPUImageLuminanceThresholdFilter *)filter setThreshold:value]; break;
        case GPUIMAGE_ADAPTIVETHRESHOLD: [(GPUImageAdaptiveThresholdFilter *)filter setBlurSize:value]; break;
        case GPUIMAGE_AVERAGELUMINANCETHRESHOLD: [(GPUImageAverageLuminanceThresholdFilter *)filter setThresholdMultiplier:value]; break;
        //case GPUIMAGE_DISSOLVE: [(GPUImageDissolveBlendFilter *)filter setMix:value]; break;
        //case GPUIMAGE_POISSONBLEND: [(GPUImagePoissonBlendFilter *)filter setMix:value]; break;
        //case GPUIMAGE_LOWPASS: [(GPUImageLowPassFilter *)filter setFilterStrength:value]; break;
        //case GPUIMAGE_HIGHPASS: [(GPUImageHighPassFilter *)filter setFilterStrength:value]; break;
        //case GPUIMAGE_MOTIONDETECTOR: [(GPUImageMotionDetector *)filter setLowPassFilterStrength:value]; break;
        //case GPUIMAGE_CHROMAKEY: [(GPUImageChromaKeyBlendFilter *)filter setThresholdSensitivity:value]; break;
        //case GPUIMAGE_CHROMAKEYNONBLEND: [(GPUImageChromaKeyFilter *)filter setThresholdSensitivity:value]; break;
        case GPUIMAGE_KUWAHARA: [(GPUImageKuwaharaFilter *)filter setRadius:round(value)]; break;
        case GPUIMAGE_SWIRL: [(GPUImageSwirlFilter *)filter setAngle:value]; break;
        case GPUIMAGE_EMBOSS: [(GPUImageEmbossFilter *)filter setIntensity:value]; break;
        case GPUIMAGE_CANNYEDGEDETECTION: [(GPUImageCannyEdgeDetectionFilter *)filter setBlurSize:value]; break;
            //        case GPUIMAGE_CANNYEDGEDETECTION: [(GPUImageCannyEdgeDetectionFilter *)filter setLowerThreshold:value]; break;
        //case GPUIMAGE_HARRISCORNERDETECTION: [(GPUImageHarrisCornerDetectionFilter *)filter setThreshold:value]; break;
        //case GPUIMAGE_NOBLECORNERDETECTION: [(GPUImageNobleCornerDetectionFilter *)filter setThreshold:value]; break;
        //case GPUIMAGE_SHITOMASIFEATUREDETECTION: [(GPUImageShiTomasiFeatureDetectionFilter *)filter setThreshold:value]; break;
        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR: [(GPUImageHoughTransformLineDetector *)filter setLineDetectionThreshold:value]; break;
            //        case GPUIMAGE_HARRISCORNERDETECTION: [(GPUImageHarrisCornerDetectionFilter *)filter setSensitivity:value]; break;
        case GPUIMAGE_THRESHOLDEDGEDETECTION: [(GPUImageThresholdEdgeDetectionFilter *)filter setThreshold:value]; break;
        case GPUIMAGE_SMOOTHTOON: [(GPUImageSmoothToonFilter *)filter setBlurSize:value]; break;
        case GPUIMAGE_THRESHOLDSKETCH: [(GPUImageThresholdSketchFilter *)filter setThreshold:value]; break;
            //        case GPUIMAGE_BULGE: [(GPUImageBulgeDistortionFilter *)filter setRadius:value]; break;
        case GPUIMAGE_BULGE: [(GPUImageBulgeDistortionFilter *)filter setScale:value]; break;
        case GPUIMAGE_SPHEREREFRACTION: [(GPUImageSphereRefractionFilter *)filter setRadius:value]; break;
        case GPUIMAGE_GLASSSPHERE: [(GPUImageGlassSphereFilter *)filter setRadius:value]; break;
        case GPUIMAGE_TONECURVE: [(GPUImageToneCurveFilter *)filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, value)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]]; break;
        case GPUIMAGE_HIGHLIGHTSHADOW: [(GPUImageHighlightShadowFilter *)filter setHighlights:value]; break;
        case GPUIMAGE_PINCH: [(GPUImagePinchDistortionFilter *)filter setScale:value]; break;
        case GPUIMAGE_PERLINNOISE:  [(GPUImagePerlinNoiseFilter *)filter setScale:value]; break;
        case GPUIMAGE_MOSAIC:  [(GPUImageMosaicFilter *)filter setDisplayTileSize:CGSizeMake(value, value)]; break;
        case GPUIMAGE_VIGNETTE: [(GPUImageVignetteFilter *)filter setVignetteEnd:value]; break;
        case GPUIMAGE_GAUSSIAN: [(GPUImageGaussianBlurFilter *)filter setBlurSize:value]; break;
            //        case GPUIMAGE_BILATERAL: [(GPUImageBilateralFilter *)filter setBlurSize:value]; break;
        case GPUIMAGE_BILATERAL: [(GPUImageBilateralFilter *)filter setDistanceNormalizationFactor:value]; break;
        case GPUIMAGE_FASTBLUR: [(GPUImageFastBlurFilter *)filter setBlurPasses:round(value)]; break;
            //        case GPUIMAGE_FASTBLUR: [(GPUImageFastBlurFilter *)filter setBlurSize:value]; break;
        case GPUIMAGE_MOTIONBLUR: [(GPUImageMotionBlurFilter *)filter setBlurAngle:value]; break;
        case GPUIMAGE_ZOOMBLUR: [(GPUImageZoomBlurFilter *)filter setBlurSize:value]; break;
        //case GPUIMAGE_OPACITY:  [(GPUImageOpacityFilter *)filter setOpacity:value]; break;
        case GPUIMAGE_GAUSSIAN_SELECTIVE: [(GPUImageGaussianSelectiveBlurFilter *)filter setExcludeCircleRadius:value]; break;
        case GPUIMAGE_GAUSSIAN_POSITION: [(GPUImageGaussianBlurPositionFilter *)filter setBlurRadius:value]; break;
        //case GPUIMAGE_FILTERGROUP: [(GPUImagePixellateFilter *)[(GPUImageFilterGroup *)filter filterAtIndex:1] setFractionalWidthOfAPixel:value]; break;
        case GPUIMAGE_CROP: [(GPUImageCropFilter *)filter setCropRegion:CGRectMake(0.0, 0.0, 1.0, value)]; break;
        case GPUIMAGE_TRANSFORM: [(GPUImageTransformFilter *)filter setAffineTransform:CGAffineTransformMakeRotation(value)]; break;
        case GPUIMAGE_TRANSFORM3D:
        {
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, value, 0.0, 1.0, 0.0);
            
            [(GPUImageTransformFilter *)filter setTransform3D:perspectiveTransform];
        }; break;
        case GPUIMAGE_TILTSHIFT:
        {
            CGFloat midpoint = value;
            [(GPUImageTiltShiftFilter *)filter setTopFocusLevel:midpoint - 0.1];
            [(GPUImageTiltShiftFilter *)filter setBottomFocusLevel:midpoint + 0.1];
        }; break;
//        case GPUIMAGE_LOCALBINARYPATTERN:
//        {
//            CGFloat multiplier = value;
//            [(GPUImageLocalBinaryPatternFilter *)filter setTexelWidth:(multiplier / self.view.bounds.size.width)];
//            [(GPUImageLocalBinaryPatternFilter *)filter setTexelHeight:(multiplier / self.view.bounds.size.height)];
//        }; break;
        default: break;
    }
    return filter;
}


@end
