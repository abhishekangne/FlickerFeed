//
//  FlickerPhotoDetailViewController.h
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/5/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickerPhoto.h"

@interface FlickerPhotoDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *flickerPhotoView;
@property (weak, nonatomic) FlickerPhoto *photo;

@end
