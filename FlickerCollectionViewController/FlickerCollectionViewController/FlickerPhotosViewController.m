//
//  FlickerPhotosViewControllerCollectionViewController.m
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/2/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import "FlickerPhotosViewController.h"
#import "FlickerPhotoDetailViewController.h"
#import "FlickerPhotosFetcher.h"
#import "FlickerPhotoCell.h"

@interface FlickerPhotosViewController ()

@end

@implementation FlickerPhotosViewController

static NSString * const reuseIdentifier = @"FlickerCell";

- (void) loadMorePhotos {
    self.photosToLoad = [[self.morePhotosToLoad arrayByAddingObjectsFromArray:self.photosToLoad] mutableCopy];
    [self.morePhotosToLoad removeAllObjects];
    [UIView animateWithDuration:0.5 animations:^{
        self.loadMoreButton.frame = CGRectMake(self.loadMoreButton.frame.origin.x, -50.0, self.loadMoreButton.frame.size.width, self.loadMoreButton.frame.size.height);
        [self.collectionView reloadData];
    } completion:^(BOOL finished) {
        NSIndexPath *indxPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indxPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];
}


- (void) setupLoadMorePhotosButton {
    self.loadMoreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loadMoreButton setFrame: CGRectMake((self.collectionView.frame.size.width / 2.0) - 60.0, -50.0, 120.0, 30.0)];
    [self.loadMoreButton setTitle:@"Load More" forState:UIControlStateNormal];
    [self.loadMoreButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.loadMoreButton.layer.cornerRadius = 4;
    self.loadMoreButton.layer.borderWidth = 1;
    self.loadMoreButton.layer.borderColor = [UIColor orangeColor].CGColor;
    self.loadMoreButton.layer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.loadMoreButton addTarget:self action:@selector(loadMorePhotos) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view insertSubview:self.loadMoreButton aboveSubview:self.collectionView];
    
}

- (void) updatePhotosOnUI :(NSArray*)photos {
    self.morePhotosToLoad = [[NSMutableArray alloc] initWithArray:photos];
    self.photosToLoad = [self.morePhotosToLoad mutableCopy];
    [self.morePhotosToLoad removeAllObjects];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0 animations:^{
            [self.collectionView performBatchUpdates:^{
                NSMutableArray* arrayWithIndexPaths = [NSMutableArray new];
                for (int i = 0; i < [self.photosToLoad count]; i++) {
                    [arrayWithIndexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
                [self.collectionView insertItemsAtIndexPaths:arrayWithIndexPaths];
            } completion:nil];
        }];
    });
    
}

- (void) fetchPhotos {
    
    [FlickerPhotosFetcher fetchFlickerPhotos:^(NSArray *photos, NSError *error) {

        if (self.photosToLoad.count == 0) {
            [self updatePhotosOnUI:photos];
        }
        else {
            self.morePhotosToLoad = [[self.morePhotosToLoad arrayByAddingObjectsFromArray:photos] mutableCopy];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.5 animations:^{
                    self.loadMoreButton.frame = CGRectMake((self.collectionView.frame.size.width / 2.0) - 60.0, 80.0, self.loadMoreButton.frame.size.width, self.loadMoreButton.frame.size.height);
                }];
            });
            
        }
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor = UIColor.orangeColor;
    self.photosToLoad = [NSMutableArray new];
    
    [self setupLoadMorePhotosButton];
    [self fetchPhotos];
    
    [NSTimer scheduledTimerWithTimeInterval:10.0
                                     target:self
                                   selector:@selector(fetchPhotos)
                                   userInfo:nil
                                    repeats:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"showPhotoDetail"]) {
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        FlickerPhotoDetailViewController *detailViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        detailViewController.photo = [self.photosToLoad objectAtIndex:indexPath.row];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosToLoad.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickerPhotoCell *cell = (FlickerPhotoCell*)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    FlickerPhoto* photo = [self.photosToLoad objectAtIndex:[indexPath row]];
    cell.photo = photo;
    cell.authorLabel.text = photo.author;
    cell.titleLabel.text = photo.title;

    // Configure the cell
    return cell;
}

@end
