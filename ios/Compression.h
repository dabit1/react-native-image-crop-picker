//
//  Compression.h
//  imageCropPicker
//
//  Created by Ivan Pusic on 12/24/16.
//  Copyright © 2016 Ivan Pusic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageResult : NSObject

@property NSData *data;
@property NSNumber *width;
@property NSNumber *height;
@property NSString *mime;
@property UIImage *image;

@end

@interface Compression : NSObject

- (ImageResult*) compressImage:(UIImage*)image withOptions:(NSDictionary*)options;

@end
