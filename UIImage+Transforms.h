//
//  UIImage+Transforms.h
//  mergesort
//
//  Created by Joe on 11/7/13.
//  Copyright (c) 2013 Picks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Transforms)

+ (UIImage *)blankImage;
+ (UIImage *)imageOfColor:(UIColor *)color;
- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage *)imageScaledToSize:(CGSize)size;
- (UIImage *)imageSmoothlyScaledToSize:(CGSize)size;
+ (UIImage *)imageFromLayer:(CALayer *)layer;
+ (UIImage *)stitchImages:(NSArray *)images vertically:(BOOL)vertically;
- (UIImage *)colorizeImageWithColor:(UIColor *)color;
- (UIImage *)colorizeImageWithColor:(UIColor *)color withBlendMode:(CGBlendMode)blendMode;

@end
