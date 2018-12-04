//
//  NNHomeTopView.h
//  YWL
//
//  Created by 牛牛 on 2018/4/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHomeTopView : UIImageView

@property (nonatomic, copy) void (^selectedSegmentIndexBlock)(NSInteger index);

- (instancetype)initWithTitle:(NSString *)title detailTitles:(NSArray *)detailTitles;

@end
