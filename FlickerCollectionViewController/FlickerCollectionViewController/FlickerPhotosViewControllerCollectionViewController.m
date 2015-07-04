//
//  FlickerPhotosViewControllerCollectionViewController.m
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/2/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import "FlickerPhotosViewControllerCollectionViewController.h"
#import "FlickerPhotosFetcher.h"
#import "FlickerPhotoCell.h"

@interface FlickerPhotosViewControllerCollectionViewController ()

@end

@implementation FlickerPhotosViewControllerCollectionViewController

static NSString * const reuseIdentifier = @"FlickerCell";

- (void) fetchPhotos {
    
//    [FlickerPhotosFetcher fetchFlickerPhotos:^(NSArray *photos, NSError *error) {
//        self.photosToLoad = photos;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.collectionView reloadData];
//        });
//    }];
    
    [FlickerPhotosFetcher fetchFlickerPhotos:^(NSArray *photos, NSError *error) {
        NSMutableArray* allPhotos = [[NSMutableArray alloc] initWithArray:photos];
        self.photosToLoad = [[allPhotos arrayByAddingObjectsFromArray:self.photosToLoad] mutableCopy];
        
        [UIView animateWithDuration:0 animations:^{
            [self.collectionView performBatchUpdates:^{
                NSMutableArray* arrayWithIndexPaths = [NSMutableArray new];
                for (int i = 0; i < [photos count]; i++) {
                    [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
            } completion:nil];
        }];
        
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = UIColor.orangeColor;
    self.photosToLoad = [NSMutableArray new];
    
    [self fetchPhotos];
    
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(fetchPhotos)
                                   userInfo:nil
                                    repeats:YES];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosToLoad.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickerPhotoCell *cell = (FlickerPhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.photo = [self.photosToLoad objectAtIndex:[indexPath row]];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(nonnull UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {

}
/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
