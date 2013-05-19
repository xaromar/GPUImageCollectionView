//
//  ViewController.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 8/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import "UIImage+Resize.h"
#import "SelectImageViewController.h"
#import "FilterCollectionViewController.h"

@interface SelectImageViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelNoImage;

@property (nonatomic, strong) UIPopoverController *popOver;

@end

@implementation SelectImageViewController

- (IBAction)filterButtonPressed:(id)sender {
    if(self.imageSelected.image != nil){
        FilterCollectionViewController *filterCollectionViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"FilterCollectionViewController"];
        filterCollectionViewController.rawSourceImage = self.imageSelected.image;
        filterCollectionViewController.sourceImage = [UIImage imageWithImage:self.imageSelected.image scaledToSize:CGSizeMake(140, 140)];
        filterCollectionViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:filterCollectionViewController animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                           message:@"Please select an image to filter."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)photoFromAlbum:(id)sender {
    UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
    photoPicker.delegate = self;
    photoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:photoPicker];
        [popover presentPopoverFromRect:CGRectMake(0, 960, 60, 380) inView:[self view] permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        self.popOver = popover;
    } else {
        [self presentViewController:photoPicker animated:YES completion:NULL];
    }
}

- (IBAction)photoFromCamera
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *photoPicker = [[UIImagePickerController alloc] init];
        photoPicker.delegate = self;
        photoPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:photoPicker animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sorry..."
                                                        message:@"Your device does not have camera, please select an image from your album."
                                                       delegate:self cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.labelNoImage.hidden = YES;
    UIImage *selectedImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    self.imageSelected.image = selectedImage;
    [photoPicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
