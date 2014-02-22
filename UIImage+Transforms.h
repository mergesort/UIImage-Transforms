//
//  UIImage+Transforms.h
//  Beta
//
//  Created by Joe on 11/7/13.
//  Copyright (c) 2013 Betaworks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Transforms)

+ (UIImage *)blankImage;
+ (UIImage *)imageOfColor:(UIColor *)color;
- (UIImage *)tintedGradientImageWithColor:(UIColor *)tintColor;
- (UIImage *)tintedImageWithColor:(UIColor *)tintColor;
- (UIImage *)imageScaledToSize:(CGSize)size;
+ (UIImage *)imageFromLayer:(CALayer *)layer;

@end
