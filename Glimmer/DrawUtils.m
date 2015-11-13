//
//  DrawUtils.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/29.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import "DrawUtils.h"

@implementation DrawUtils

//等比缩放后截取(没必要截取，对象直接缩放就可以了)
+(UIImage *)clipImageInScale:(UIImage *)image toScale:(float)scale
{
    const int position = 0;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scale, image.size.height * scale));
    [image drawInRect:CGRectMake(position, position, image.size.width * scale, image.size.height * scale)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return clipImage;
}

//原图截取一部分
+(UIImage *)clipImageInRect:(UIImage*)image toRect:(CGRect)rect
{
    //UIImage *image = [UIImage imageNamed:@"black.png"];
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *clipImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return clipImage;
}
@end
