//
//  FlickerPhotoCell.m
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/3/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import "FlickerPhotoCell.h"

@implementation FlickerPhotoCell

-(void) setPhoto:(FlickerPhoto *)photo {
    if(_photo != photo) {
        _photo = photo;
    }
    self.imageView.image = _photo.image;
}

@end
