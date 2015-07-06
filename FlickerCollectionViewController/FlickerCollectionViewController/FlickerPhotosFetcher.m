//
//  FlickerPhotosFetcher.m
//  FlickerCollectionViewController
//
//  Created by Abhishek Angne on 7/3/15.
//  Copyright © 2015 Abhishek Angne. All rights reserved.
//

#import "FlickerPhotosFetcher.h"
#import "AFNetworking.h"
#import "FlickerPhoto.h"

@implementation FlickerPhotosFetcher

static NSString* const urlString = @"https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1";

+ (void) fetchFlickerPhotos:(FlickerPhotosFetchCompletionBlock) completionBlock {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    //Set completionQueue to background. AFNetworking defaults to main queue otherwise
    manager.completionQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"application/x-javascript"];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSError* error = nil;
        NSString* stringFromData = [[NSString alloc] initWithData:responseObject encoding: NSUTF8StringEncoding];
        NSString* escapedString = [stringFromData stringByReplacingOccurrencesOfString:@"\\'" withString:@"'"];
        
        NSData* escapedData = [escapedString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:escapedData options:0 error:&error];
        if (error != nil) {
            NSLog(@"Error: %@", error);
            completionBlock(nil,error);
        }
        else {
            
            NSArray* items = responseDict[@"items"];
            NSMutableArray* photos = [NSMutableArray new];
            
            for(NSMutableDictionary *item in items)
            {
                FlickerPhoto *photo = [[FlickerPhoto alloc] init];
                photo.link = item[@"link"];
                photo.title = item[@"title"];
                photo.media = item[@"media"];
                photo.author = item[@"author"];
                photo.published = item[@"published"];
                photo.author_id = item[@"author_id"];
                photo.date_taken = item[@"date_taken"];
                photo.photo_description = item[@"photo_description"];
                photo.tags = item[@"tags"];
                
                NSString* photoUrl = photo.media[@"m"];
                NSError* error = nil;
                NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoUrl] options:0 error:&error];
                UIImage *image = [UIImage imageWithData:imageData];
                photo.image = image;
                
                [photos addObject:photo];
            }
            completionBlock(photos,nil);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

@end
