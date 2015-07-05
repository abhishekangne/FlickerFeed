//
//  FlickerPhotoCell.h
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/3/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickerPhoto.h"

@interface FlickerPhotoCell : UICollectionViewCell

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) FlickerPhoto *photo;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
