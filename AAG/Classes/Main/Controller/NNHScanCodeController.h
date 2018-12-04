//
//  NNHScanCodeController.h
//  NNHPlatform
//
//  Created by 来旭磊 on 17/3/18.
//  Copyright © 2017年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHScanCodeController : UIViewController

@property (nonatomic, copy) void(^getQrCodeBlock)(NSString *code);

@end
