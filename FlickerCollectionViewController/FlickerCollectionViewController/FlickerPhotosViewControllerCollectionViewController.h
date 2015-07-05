//
//  FlickerPhotosViewControllerCollectionViewController.h
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/2/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickerPhotosViewControllerCollectionViewController : UICollectionViewController

@property(nonatomic,strong) NSMutableArray* photosToLoad;
@property(nonatomic,strong) UIButton* loadMoreButton;

@end
