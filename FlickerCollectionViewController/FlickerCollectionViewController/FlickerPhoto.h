//
//  FlickerPhoto.h
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/3/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//  Data object for Flickr Photo item

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickerPhoto : NSObject
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* link;
@property(nonatomic, strong) NSDictionary* media;
@property(nonatomic, strong) NSString* author;
@property(nonatomic, strong) NSString* published;
@property(nonatomic, strong) NSString* author_id;
@property(nonatomic, strong) NSString* date_taken;
@property(nonatomic, strong) NSString* photo_description;
@property(nonatomic, strong) NSString* tags;
@property(nonatomic, strong) UIImage* image;

@end
