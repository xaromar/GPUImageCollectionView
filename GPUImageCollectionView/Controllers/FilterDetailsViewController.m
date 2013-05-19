//
//  FilterDetailsViewController.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 11/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "FilterDetailsViewController.h"
#import "FilterList.h"
#import "Filtrator.h"
#import "PhotoInfo.h"
#import "FilterInfo.h"
#import "UIImage+Resize.h"
#import "UISlider+Tools.h"

@interface FilterDetailsViewController ()
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) Filtrator *filtrator;
@property (strong, nonatomic) FilterInfo *filterInfo;
@property (strong, nonatomic) GPUImagePicture *gpuImagePicture;
@property (nonatomic, strong) UIImage *sourceImage;

@end

@implementation FilterDetailsViewController

- (UIImage *)processRawImage:(UIImage *)inputImage{
    UIImage *outputImage;
    outputImage = [UIImage imageWithImage:inputImage scaleProportionalToSize:self.imageToShow.bounds.size];
    //NSLog (@"Input image size: %f %f", inputImage.size.width, inputImage.size.height);
    //NSLog (@"Output image size: %f %f", outputImage.size.width, outputImage.size.height);
    
    //This is required because there is an issue in GPUImage library with the rotation for pictures taken with the camera
    //https://github.com/BradLarson/GPUImage/issues/594
    
    UIGraphicsBeginImageContext(outputImage.size);
    [outputImage drawInRect:CGRectMake(0, 0, outputImage.size.width, outputImage.size.height)];
    outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

#pragma mark -
#pragma mark - Slider change

- (IBAction)sliderValueChanged:(UISlider *)slider
{
    if(self.filterInfo.filterSettingsSlider){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            self.filterInfo.filter = [self.filtrator updateFilterWithSliderValue:[slider value] forFilter:self.filterInfo.filter];
            [self.gpuImagePicture processImage];
        });
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    else
        alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                           message:@"Image saved to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    
    
    [alert show];
}

#pragma mark - Button actions
- (IBAction)shareButtonPressed:(id)sender
{
    UIImage *imageToSave = [self.filterInfo.filter imageFromCurrentlyProcessedOutput];
    
    if ([UIActivityViewController class]){
        UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:@[imageToSave] applicationActivities:nil];
        [self presentViewController:activityController animated:YES completion:nil];
    }
    else{
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (IBAction)backButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.slider setMetallicThumb];
    
    self.sourceImage = [self processRawImage:self.rawImage];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.gpuImagePicture = [[GPUImagePicture alloc] initWithImage:self.sourceImage smoothlyScaleOutput:YES];
        self.filtrator = [[Filtrator alloc]initWithFilterType:self.filterType];
        self.filterInfo = [self.filtrator startFilter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationBar.topItem.title = self.filterInfo.name;
            self.slider.hidden = self.filterInfo.filterSettingsSlider.hidden;
            self.slider.minimumValue = self.filterInfo.filterSettingsSlider.minimumValue;
            self.slider.maximumValue = self.filterInfo.filterSettingsSlider.maximumValue;
            self.slider.value = self.filterInfo.filterSettingsSlider.value;
        });
        
        [self.gpuImagePicture addTarget:self.filterInfo.filter];
        [self.filterInfo.filter addTarget:self.imageToShow];
        [self.gpuImagePicture processImage];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
