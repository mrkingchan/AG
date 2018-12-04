//
//  NNMineOperationRollTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationRollCell.h"

@interface NNMineOperationRollCell ()

/** <#注释#> */
@property (nonatomic, strong) UIImageView *rollImageView;

@end

@implementation NNMineOperationRollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.rollImageView];
    [self.rollImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_height).multipliedBy(0.8);
        make.width.equalTo(self.contentView);
    }];
}

- (void)setImageName:(NSString *)imageName
{
    _imageName = imageName;
    self.rollImageView.image = [UIImage imageNamed:imageName];
}

- (UIImageView *)rollImageView
{
    if (_rollImageView == nil) {
        _rollImageView = [[UIImageView alloc] init];
    }
    return _rollImageView;
}

@end
