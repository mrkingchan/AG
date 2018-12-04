//
//  NNRealNameAuthenticationViewController.m
//  NBTMill
//
//  Created by 牛牛 on 2018/5/8.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNRealNameAuthenticationViewController.h"
#import "NNTextField.h"
#import "NNAPIMineTool.h"
#import "UIButton+NNImagePosition.h"

@interface NNRealNameAuthenticationViewController () <UITextFieldDelegate>

/** 用户数据 */
@property (nonatomic, strong) NNUserModel *userModel;
/** 姓名 */
@property (nonatomic, strong) NNTextField *nickNameTF;
/** 身份证 */
@property (nonatomic, strong) NNTextField *cardTF;
/** 照片容器 */
@property (nonatomic, strong) UIView *photoContentView;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation NNRealNameAuthenticationViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"实名认证";
    
    // 用户数据
    _userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    
    [self setupChildView];
}

- (void)setupChildView
{
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
    
    [self.view addSubview:self.nickNameTF];
    [self.view addSubview:self.cardTF];
    [self.view addSubview:lineView];
    [self.view addSubview:self.sureButton];
    [self.view addSubview:self.photoContentView];
    
    [self.nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NNHMargin_15));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.mas_bottom);
        make.left.right.equalTo(self.nickNameTF);
        make.height.equalTo(@(NNHLineH));
    }];
    [self.cardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self.nickNameTF);
        make.height.equalTo(self.nickNameTF);
    }];
    [self.photoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardTF.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(self.view.mas_width).multipliedBy(0.67);
    }];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoContentView.mas_bottom).offset(NNHMargin_20*2);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)sureRealNameAction
{
    NNHWeakSelf(self)
    NNAPIMineTool *tool = [[NNAPIMineTool alloc] initUserAuthenticationWithTruename:self.nickNameTF.text idcardNum:self.cardTF.text idcardImage:@"325235236"];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD showMessage:@"认证成功"];
        weakself.userModel.truename = weakself.nickNameTF.text;
        weakself.userModel.idcard = weakself.cardTF.text;
        weakself.userModel.idcardauth = @"2";
        [weakself.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)uploadPhotoAction:(UIButton *)button
{
    
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNTextField *)textField
{
    self.sureButton.enabled = self.nickNameTF.hasText && self.cardTF.hasText;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNTextField *)nickNameTF
{
    if (_nickNameTF == nil) {
        _nickNameTF = [[NNTextField alloc] init];
        [_nickNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        if ([_userModel.idcardauth integerValue] == 1 || ![NSString isEmptyString:_userModel.truename]) {
            _nickNameTF.text = _userModel.truename;
            _nickNameTF.enabled = NO;
        }else{
            _nickNameTF.placeholder = @"真实姓名";
            _nickNameTF.enabled = YES;
        }
    }
    return _nickNameTF;
}

- (NNTextField *)cardTF
{
    if (_cardTF == nil) {
        _cardTF = [[NNTextField alloc] init];
        [_cardTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _cardTF.keyboardType = UIKeyboardTypeASCIICapable;
        _cardTF.nn_maxLength = 18;
        if ([_userModel.idcardauth integerValue] == 1 || ![NSString isEmptyString:_userModel.idcard]) {
            _cardTF.text = [_userModel.idcard replaceStringWithAsterisk:6 length:_userModel.idcard.length - 10];
            _cardTF.enabled = NO;
        }else{
            _cardTF.placeholder = @"身份证号";
            _cardTF.enabled = YES;
        }
    }
    return _cardTF;
}

- (UIButton *)sureButton
{
    if (_sureButton == nil) {
        _sureButton = [UIButton NNHOperationBtnWithTitle:@"提交" target:self action:@selector(sureRealNameAction) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _sureButton.nn_acceptEventInterval = NNHAcceptEventInterval;
        _sureButton.hidden = [_userModel.idcardauth integerValue] == 1;
        _sureButton.enabled = [_userModel.idcardauth integerValue] != 1;
    }
    return _sureButton;
}

- (UIView *)photoContentView
{
    if (_photoContentView == nil) {
        _photoContentView = [[UIView alloc] init];
        _photoContentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _photoContentView.hidden = [_userModel.idcardauth integerValue] == 1;
        
        CGFloat btnW = (SCREEN_WIDTH - 40) / 2;
        CGFloat btnH = btnW * 2 / 3;
        UIButton *photoOneButton = [self btnWithTitle:@"上传身份证正面"];
        [_photoContentView addSubview:photoOneButton];
        [photoOneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_photoContentView);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(btnH));
        }];
        
        UIButton *photoTwoButton = [self btnWithTitle:@"上传身份证反面"];
        [_photoContentView addSubview:photoTwoButton];
        [photoTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_photoContentView);
            make.size.equalTo(photoOneButton);
        }];
        
        UIButton *photoThreeButton = [self btnWithTitle:@"上传手持身份证"];
        [_photoContentView addSubview:photoThreeButton];
        [photoThreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(photoOneButton.mas_bottom).offset(10);
            make.left.equalTo(_photoContentView);
            make.size.equalTo(photoOneButton);
        }];
    }
    return _photoContentView;
}

- (UIButton *)btnWithTitle:(NSString *)title
{
    UIButton *btn = [UIButton NNHBtnTitle:title titileFont:[UIConfigManager fontThemeTextTip] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeDarkGray]];
    [btn setImage:ImageName(@"ic_camera") forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(uploadPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn nn_setImagePosition:NNImagePositionTop spacing:10];
    btn.adjustsImageWhenHighlighted = NO;
    
    return btn;
}

@end
