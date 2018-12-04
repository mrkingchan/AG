//
//  NNHomeTopView.m
//  YWL
//
//  Created by 牛牛 on 2018/4/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNHomeTopView.h"

@implementation NNHomeTopView

- (instancetype)initWithTitle:(NSString *)title detailTitles:(NSArray *)detailTitles
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (NNHNavBarViewHeight) + 43)]) {
        
        self.image = [UIImage imageNamed:@"top_long_bg"];
        self.userInteractionEnabled = YES;
        
        [self setupChildViewWithTitle:title detailTitles:detailTitles];
    }
    return self;
}

- (void)setupChildViewWithTitle:(NSString *)title detailTitles:(NSArray *)detailTitles
{
    UILabel *titleLabel = [UILabel NNHWithTitle:title titleColor:[UIColor whiteColor] font:[UIConfigManager fontNaviTitle]];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(STATUSBAR_HEIGHT);
        make.centerX.equalTo(self);
        make.height.equalTo(@44);
    }];
    
    // 初始化UISegmentedControl
    CGFloat maxY = STATUSBAR_HEIGHT + 44;
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:detailTitles];
    segmentedControl.frame = CGRectMake(40, maxY, SCREEN_WIDTH - 80, 29);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(actionValueChanged:) forControlEvents:UIControlEventValueChanged];
    NNHViewBorderRadius(segmentedControl, 29* 0.5, 1.0, [UIColor whiteColor]);
    
    // 设置外观
    segmentedControl.tintColor = [UIColor whiteColor];
    
    // 设置文字样式
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal]; // 正常
    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor akext_colorWithHex:@"#0b288e"]} forState:UIControlStateSelected]; // 选中
    
    [self addSubview:segmentedControl];
}

- (void)actionValueChanged:(UISegmentedControl *)sender
{
    if (self.selectedSegmentIndexBlock) {
        self.selectedSegmentIndexBlock(sender.selectedSegmentIndex);
    }
}

@end
