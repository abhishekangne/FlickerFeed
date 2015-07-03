//
//  FlickerPhotosFetcher.h
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/3/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//  Utility class for network calls

#import <Foundation/Foundation.h>

typedef void(^FlickerPhotosFetchCompletionBlock)(NSArray* photos, NSError* error);

@interface FlickerPhotosFetcher : NSObject

+ (void) fetchFlickerPhotos:(FlickerPhotosFetchCompletionBlock) completionBlock;

@end
