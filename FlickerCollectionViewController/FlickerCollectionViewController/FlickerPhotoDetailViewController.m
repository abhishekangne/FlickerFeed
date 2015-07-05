//
//  FlickerPhotoDetailViewController.m
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/5/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import "FlickerPhotoDetailViewController.h"

@interface FlickerPhotoDetailViewController ()

@end

@implementation FlickerPhotoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.flickerPhotoView.image = self.photo.image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
