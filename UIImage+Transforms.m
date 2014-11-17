//
//  UIImage+Transforms.m
//  mergesort
//
//  Created by Joe on 11/7/13.
//  Copyright (c) 2013 Picks. All rights reserved.
//

#import "UIImage+Transforms.h"

@implementation UIImage (Transforms)

+ (UIImage *)blankImage
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(1, 1), NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blank;
}

+ (UIImage *)imageOfColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor
{
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeOverlay];
}

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor
{
    return [self tintedImageWithColor:tintColor blendingMode:kCGBlendModeDestinationIn];
}

- (UIImage *)imageScaledToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageSmoothlyScaledToSize:(CGSize)size
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, size.width, size.height));
    CGImageRef imageRef = self.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, size.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageFromLayer:(CALayer *)layer
{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}

+ (UIImage *)stitchImages:(NSArray *)images vertically:(BOOL)vertically
{
    CGSize canvasSize;
    CGFloat canvasWidth = 0;
    CGFloat canvasHeight = 0;
    
    if (vertically)
    {
        for (UIImage *image in images)
        {
            if (canvasWidth < image.size.width)
            {
                canvasWidth = image.size.width;
            }
            canvasHeight += image.size.height;
        }
        canvasSize = CGSizeMake(canvasWidth, canvasHeight);
    }
    else
    {
        for (UIImage *image in images)
        {
            if (canvasHeight < image.size.height)
            {
                canvasHeight = image.size.height;
            }
            canvasWidth += image.size.width;
        }
        canvasSize = CGSizeMake(canvasWidth, canvasHeight);
    }
    
    UIGraphicsBeginImageContext(canvasSize);
    
    CGFloat xPosition = 0;
    CGFloat yPosition = 0;
    
    for (UIImage *image in images)
    {
        [image drawAtPoint:CGPointMake(xPosition, yPosition)];
        if (vertically)
        {
            yPosition += image.size.height;
        }
        else
        {
            xPosition += image.size.width;
        }
    }
    
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
}

- (UIImage *)colorizeImageWithColor:(UIColor *)color {
    
    return [self colorizeImageWithColor:color withBlendMode:kCGBlendModeMultiply];
}

- (UIImage *)colorizeImageWithColor:(UIColor *)color withBlendMode:(CGBlendMode)blendMode{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    //
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
    // Flip the image
    CGContextTranslateCTM(context, 0.0, imageRect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSaveGState(context);
    CGContextDrawImage(context, imageRect, self.CGImage);
    //
    // Create Clip Mask from Image
    CGContextClipToMask(context, imageRect, self.CGImage);
    // Color it
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetBlendMode(context, blendMode);
    //
    CGContextAddRect(context, imageRect);
    CGContextDrawPath(context, kCGPathFill);
    CGContextRestoreGState(context);
    UIImage *ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return ret;
    
}


////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private methods

- (UIImage *)tintedImageWithColor:(UIColor *)tintColor blendingMode:(CGBlendMode)blendMode
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:blendMode alpha:1.0f];
    
    if (blendMode != kCGBlendModeDestinationIn)
        [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end
