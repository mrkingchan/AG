//
//  UIImage+NNHExtension.h
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/31.
//  Copyright © 2016年 NBT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (NNHExtension)

/**
 *  把目标View截图成Size大小的Image
 *
 *  @param theView 目标View
 *  @param size    目标大小
 */
+ (UIImage *)akext_imageFromView:(UIView *)theView withSize:(CGSize)size;


/**
 *  把Image模糊化
 *
 *  @param radius     模糊率
 *
 *  @return 模糊后的Image
 */
- (UIImage *)akext_blurredImageWithRadius:(CGFloat)radius
                               iterations:(NSUInteger)iterations
                                tintColor:(UIColor *)tintColor;
/*!
 @method
 @brief      矫正图片旋转
 */
+(UIImage *)akext_fixOrientation:(UIImage *)aImage;


/**
 *  image圆角
 *
 *  @param radius 圆角
 *
 */
- (UIImage*)imageAddCornerWithRadius:(CGFloat)radius imageize:(CGSize)size;

/**
 *  返回圆形图片
 */
- (instancetype)circleImage;

+ (instancetype)circleImage:(NSString *)name;

/** 根据颜色生成图片 */
+ (UIImage *)nnh_imageWithColor:(UIColor *)color;

/** 根据文字生成二维码图片 */
+ (UIImage *)createQRImageWithString:(NSString *)string imageSize:(CGSize)imageSize;

@end
