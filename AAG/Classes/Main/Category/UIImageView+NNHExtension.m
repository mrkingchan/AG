//
//  UIImageView+NNHExtension.m
//  NNHPlatform
//
//  Created by 牛牛 on 2017/5/16.
//  Copyright © 2017年 NBT. All rights reserved.
//

#import "UIImageView+NNHExtension.h"

@implementation UIImageView (NNHExtension)

- (void)nnh_addCorner:(CGFloat)radius imageSize:(CGSize)size
{
    if (self.image) {
        self.image = [self.image imageAddCornerWithRadius:radius imageize:size];
    }
}

@end
