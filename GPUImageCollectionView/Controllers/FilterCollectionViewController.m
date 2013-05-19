//
//  FilterCollectionViewController.m
//  GPUIimageCollectionView
//
//  Created by Xavi on 8/5/13.
//  Copyright (c) 2013 Xavier Roman. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import "FilterCollectionViewController.h"
#import "FilterDetailsViewController.h"
#import "FilteredImageCell.h"
#import "PhotoInfo.h"
#import "FilterList.h"

//#define RETRY_LOADING_TEXTURE_ERROR_FILTERS

@interface FilterCollectionViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation FilterCollectionViewController

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.photosFiltered.count;
}

- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FilteredImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageFiltered" forIndexPath:indexPath];

    PhotoInfo *photo = [self.photosFiltered objectAtIndex:indexPath.row];

    if ([photo isFiltered]) {
        cell.imageFiltered.image = photo.photo;
        cell.filterName.text = photo.filterName;
        
    }
    else {
        cell.imageFiltered.image = [UIImage imageNamed:@"placeholder.png"];
        cell.filterName.text = @"Not filtered yet";
        
        if (!collectionView.dragging && !collectionView.decelerating) {
            [self startOperationFilterForPhoto:photo atIndexPath:indexPath];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self cancelAllOperations];
    FilterDetailsViewController *filterDetailsViewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"FilterDetailsViewController"];
    filterDetailsViewController.rawImage = self.rawSourceImage;
    filterDetailsViewController.filterType = indexPath.row;
    filterDetailsViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:filterDetailsViewController animated:YES completion:nil];
}


#pragma mark -
#pragma mark - Operations

- (void)startOperationFilterForPhoto:(PhotoInfo *)photo atIndexPath:(NSIndexPath *)indexPath {
    
    if (!photo.isFiltered) {
        [self startImageFiltrationForPhoto:photo atIndexPath:indexPath];
    }
}

- (void)startImageFiltrationForPhoto:(PhotoInfo *)photo atIndexPath:(NSIndexPath *)indexPath {
    
    if (![self.pendingOperations.filtrationsInProgress.allKeys containsObject:indexPath]) {
        photo.photo = self.sourceImage;
        ImageFiltrationOperation *imageFiltration = [[ImageFiltrationOperation alloc] initFilterForPhoto:photo atIndexPath:indexPath delegate:self];
        //[imageFiltration setQueuePriority:NSOperationQueuePriorityVeryHigh];
        [self.pendingOperations.filtrationsInProgress setObject:imageFiltration forKey:indexPath];
        [self.pendingOperations.filtrationQueue addOperation:imageFiltration];
    }
}

#pragma mark -
#pragma mark - ImageFiltration delegate


- (void)imageFiltrationDidFinish:(ImageFiltrationOperation *)filtration {
    NSIndexPath *indexPath = filtration.indexPathInCollectionView;
    PhotoInfo *photoInfo = filtration.photoInfo;


    NSData *data = UIImagePNGRepresentation(photoInfo.photo);
    if([data length] == 989){
        photoInfo.filtered = NO;
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:indexPath];
#ifdef RETRY_LOADING_TEXTURE_ERROR_FILTERS
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
#endif
    }
    else{
        photoInfo.filtered = YES;
        [self.photosFiltered replaceObjectAtIndex:indexPath.row withObject:photoInfo];
        [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:indexPath];
    }
}

#pragma mark -
#pragma mark - UIScrollView delegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self suspendAllOperations];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForOnscreenCells];
        [self resumeAllOperations];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForOnscreenCells];
    [self resumeAllOperations];
}



#pragma mark -
#pragma mark - Cancelling, suspending, resuming queues / operations


- (void)suspendAllOperations {
    [self.pendingOperations.filtrationQueue setSuspended:YES];
}


- (void)resumeAllOperations {
    [self.pendingOperations.filtrationQueue setSuspended:NO];
}


- (void)cancelAllOperations {
    [self.pendingOperations.filtrationQueue cancelAllOperations];
}

- (void)loadImagesForOnscreenCells {
    NSSet *visibleRows = [NSSet setWithArray:[self.collectionView indexPathsForVisibleItems]];
    
    NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperations.filtrationsInProgress allKeys]];
    
    NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
    NSMutableSet *toBeStarted = [visibleRows mutableCopy];

    [toBeStarted minusSet:pendingOperations];
    
    [toBeCancelled minusSet:visibleRows];
    
    for (NSIndexPath *anIndexPath in toBeCancelled) {
        
        ImageFiltrationOperation *pendingFiltration = [self.pendingOperations.filtrationsInProgress objectForKey:anIndexPath];
        [pendingFiltration cancel];
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:anIndexPath];
    }
    toBeCancelled = nil;
    
    for (NSIndexPath *anIndexPath in toBeStarted) {
        
        PhotoInfo *photoToProcess = [self.photosFiltered objectAtIndex:anIndexPath.row];
        [self startOperationFilterForPhoto:photoToProcess atIndexPath:anIndexPath];
    }
    toBeStarted = nil;
    
}

#pragma mark -
#pragma mark - Button actions

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (PendingOperations *)pendingOperations {
    if (!_pendingOperations) {
        _pendingOperations = [[PendingOperations alloc] init];
    }
    return _pendingOperations;
}

-(NSMutableArray*)photosFiltered{
    if(!_photosFiltered){
        _photosFiltered = [NSMutableArray arrayWithCapacity:GPUIMAGE_NUMFILTERS]; //Number of filters
    }
    return _photosFiltered;
}

-(void)setupArray{
    for(int i=0;i<GPUIMAGE_NUMFILTERS;i++){
        PhotoInfo* photo = [[PhotoInfo alloc]init];
        photo.photo =nil;
        photo.filtered = FALSE;
        [self.photosFiltered addObject:photo];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupArray];
    [[self collectionView]reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"Memory warning");
}

@end
