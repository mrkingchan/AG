//
//  NNMineOperationDeatilTableViewCell.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationDeatilCell.h"

@interface NNMineOperationDeatilCell ()

/** 服务器名称 */
@property (nonatomic, strong) UILabel *serverNameLabel;
/** 信息 */
@property (nonatomic, strong) UILabel *messageLabel;
/** 服务器IP */
@property (nonatomic, strong) UILabel *serverIPLabel;

@end

@implementation NNMineOperationDeatilCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [[UIColor akext_colorWithHex:@"#392a1c"] colorWithAlphaComponent:0.8f];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.serverNameLabel];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.serverIPLabel];
    
    [self.serverNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-NNHMargin_5);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.serverNameLabel);
        make.top.equalTo(self.contentView.mas_centerY).offset(NNHMargin_5);
    }];
    
    [self.serverIPLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-NNHMargin_5);
    }];
}

- (void)setNodeModel:(NNMineOperationNodeModel *)nodeModel
{
    _nodeModel = nodeModel;
    
    self.serverNameLabel.text = [NSString stringWithFormat:@"%@",nodeModel.server];
    self.messageLabel.text = [NSString stringWithFormat:@"%@",nodeModel.text];
    self.serverIPLabel.text = [NSString stringWithFormat:@"%@",nodeModel.server_ip];
}

#pragma mark - Lazy Loads

- (UILabel *)serverNameLabel
{
    if (_serverNameLabel == nil) {
        _serverNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextMain]];
    }
    return _serverNameLabel;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"" titleColor:[[UIConfigManager colorThemeWhite] colorWithAlphaComponent:0.6] font:[UIConfigManager fontThemeTextTip]];
    }
    return _messageLabel;
}

- (UILabel *)serverIPLabel
{
    if (_serverIPLabel == nil) {
        _serverIPLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeWhite] font:[UIConfigManager fontThemeTextTip]];
    }
    return _serverIPLabel;
}

@end
