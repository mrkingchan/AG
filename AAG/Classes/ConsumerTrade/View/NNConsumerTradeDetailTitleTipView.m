//
//  NNConsumerTradeDetailTitleTipView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/21.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeDetailTitleTipView.h"

@interface NNConsumerTradeDetailTitleTipView ()

/** 文字 */
@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation NNConsumerTradeDetailTitleTipView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor akext_colorWithHex:@"#fff3d9"];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.messageLabel];
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.centerY.equalTo(self);
    }];
}

- (void)setMessage:(NSString *)message
{
    _message = message;
    self.messageLabel.text = message;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
        _messageLabel.numberOfLines = 2;
    }
    return _messageLabel;
}

@end
