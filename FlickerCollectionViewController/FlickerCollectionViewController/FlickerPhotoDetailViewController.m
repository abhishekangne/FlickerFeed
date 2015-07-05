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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
