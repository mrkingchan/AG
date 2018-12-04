//
//  NNHLoginViewController.h
//  NNCivetCat
//
//  Created by 牛牛 on 2017/2/27.
//  Copyright © 2017年 灵猫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHLoginViewController : UIViewController

typedef  void (^completionBlock)(void);

/** 登陆成功的回调 */
@property (nonatomic, copy) completionBlock successLoginblock;


@end
