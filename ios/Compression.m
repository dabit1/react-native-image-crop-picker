//
//  Compression.m
//  imageCropPicker
//
//  Created by Ivan Pusic on 12/24/16.
//  Copyright © 2016 Ivan Pusic. All rights reserved.
//

#import "Compression.h"

@implementation Compression

- (ImageResult*) compressImageDimensions:(UIImage*)image withOptions:(NSDictionary*)options {
    NSNumber *maxWidth = [options valueForKey:@"compressMaxWidth"];
    NSNumber *maxHeight = [options valueForKey:@"compressMaxHeight"];
    ImageResult *result = [[ImageResult alloc] init];
    
    if ([maxWidth integerValue] == 0 || [maxWidth integerValue] == 0) {
        result.width = [NSNumber numberWithFloat:image.size.width];
        result.height = [NSNumber numberWithFloat:image.size.height];
        result.image = image;
        return result;
    }
    
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? [maxWidth floatValue] / oldWidth : [maxHeight floatValue] / oldHeight;
    
    CGFloat newWidth = oldWidth * scaleFactor;
    CGFloat newHeight = oldHeight * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    result.width = [NSNumber numberWithFloat:newWidth];
    result.height = [NSNumber numberWithFloat:newHeight];
    result.image = resizedImage;
    return result;
}

- (ImageResult*) compressImage:(UIImage*)image withOptions:(NSDictionary*)options {
    ImageResult *result = [self compressImageDimensions:image withOptions:options];
    
    int compressQuality = [options valueForKey:@"compressQuality"];
    result.data = UIImageJPEGRepresentation(result.image, compressQuality);
    result.mime = @"image/jpeg";
    
    return result;
}

@end
