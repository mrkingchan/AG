//
//  NNImageBaseRequest.h
//  YWL
//
//  Created by 牛牛 on 2018/3/29.
//  Copyright © 2018年 NBT. All rights reserved.
//

#import "YTKRequest.h"
#import "NNHRequestError.h"
#import "NNUploadImageModel.h"

@interface NNImageBaseRequest : YTKRequest

- (instancetype)initWithModel:(NNUploadImageModel *)upLoadImageModel image:(UIImage *)image;
- (void)image_StartRequestWithSucBlock:(void(^)(NSDictionary *responseDic))sucBlock
                             failBlock:(void(^)(NNHRequestError *error))failBlock;

@end
