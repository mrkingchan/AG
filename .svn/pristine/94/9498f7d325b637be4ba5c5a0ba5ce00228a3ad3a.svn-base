//
//  NNMineCommunityCell.m
//  YWL
//
//  Created by 牛牛 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineCommunityCell.h"
#import "NNMineCommunityModel.h"

@interface NNMineCommunityCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *timeLabel;

@end

@implementation NNMineCommunityCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupChlidView];
    }
    return self;
}

- (void)setupChlidView
{
    UIView *contView = [[UIView alloc] init];
    contView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    [contView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contView);
        make.left.equalTo(contView);
    }];
    
    [contView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contView);
        make.right.equalTo(contView);
    }];
}

- (void)setCommunityModel:(NNMineCommunityModel *)communityModel
{
    _communityModel = communityModel;
    
    self.titleLabel.text = communityModel.username;
    self.timeLabel.text = communityModel.createtime;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#999999"] font:[UIConfigManager fontThemeTextMiddleTip]];
        _timeLabel.backgroundColor = [UIColor whiteColor];
    }
    return _timeLabel;
}

@end
