//
//  NNConsumerTradeAppealViewController.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/23.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNConsumerTradeAppealViewController.h"
#import "NNConsumerTradeAppealResultViewController.h"
#import "NNTextView.h"
#import "NNHUploadPictureView.h"
#import "NNUploadImageTool.h"
#import "NNImagePickerViewController.h"
#import "NNHAPIConsumerTradeTool.h"
#import "NNConsumerTradeAppealResultViewController.h"

@interface NNConsumerTradeAppealViewController () <UITextViewDelegate, NNHUploadPictureViewDelegate>

@property (nonatomic, strong) NNTextView *textView;
/** 上传图片控件 */
@property (nonatomic, strong) NNHUploadPictureView *pictureView;
/** 提交按钮 */
@property (nonatomic, weak) UIButton *submitButton;
/** 订单id */
@property (nonatomic, copy) NSString *orderID;

@end

@implementation NNConsumerTradeAppealViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    NNHLog(@"-------%s------",__func__);
}
- (instancetype)initWithOrderID:(NSString *)orderID
{
    self = [super init];
    if (self) {
        _orderID = orderID;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = @"我要申诉";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];

    [self setupChildView];
}

- (void)setupChildView
{
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIConfigManager colorThemeWhite];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(SCREEN_WIDTH * 2 / 3 + 80));
    }];
    
    // 内容区
    [contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(NNHMargin_10);
        make.left.equalTo(contentView).offset(NNHMargin_10);
        make.height.equalTo(@(80));
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];

    [contentView addSubview:self.pictureView];
    [self.pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(10);
        make.centerX.equalTo(contentView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.mas_equalTo(@(SCREEN_WIDTH * 2 / 3));
    }];

    // 按钮
    UIButton *submitButton = [UIButton NNHOperationBtnWithTitle:@"提交" target:self action:@selector(submitAction) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
//    submitButton.enabled = NO;
    self.submitButton = submitButton;
    submitButton.nn_acceptEventInterval = 1;
    [self.view addSubview:submitButton];
    [submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_bottom).offset(40);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.height.equalTo(@44);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)submitAction
{
    NNHWeakSelf(self)
    if (self.pictureView.pictureArray.count) {
        [NNUploadImageTool uploadImageArray:self.pictureView.pictureArray completeArray:^(NSArray *imageArray) {
            
            NSString *string = [imageArray componentsJoinedByString:@","];
            
            [weakself uplaodAppealDataWithImageString:string];
        }];
    }else {
        [self uplaodAppealDataWithImageString:@""];
    }
}

- (void)uplaodAppealDataWithImageString:(NSString *)imageString
{
    NNHWeakSelf(self)
    NNHAPIConsumerTradeTool *tradeTool = [[NNHAPIConsumerTradeTool alloc] initSubmitAppealDataWithTradeID:self.orderID content:self.textView.text imgs:imageString];
    [tradeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {        
        if (weakself.reloadDataBlock) {
            weakself.reloadDataBlock();
        }
        
        NNConsumerTradeAppealResultViewController *resultVc = [[NNConsumerTradeAppealResultViewController alloc] init];
        [weakself.navigationController pushViewController:resultVc animated:YES];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)textViewDidChange:(UITextView *)textView
{
    self.submitButton.enabled = textView.hasText;
}

#pragma mark -
#pragma mark ---------NNHUploadPictureViewDelegate
/** 点击了最后一张图片 */
- (void)didSelectedLastImageAtPictureView:(NNHUploadPictureView *)pictureView
{
    NNImagePickerViewController *imagePickerVc = [[NNImagePickerViewController alloc] initWithMaxImagesCount:5 delegate:nil];
    // 你可以通过block或者代理，来得到用户选择的照片.

    NNHWeakSelf(self)
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        [weakself.pictureView addPictureFromArray:photos];
    }];

    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark -
#pragma mark ---------Getters & Setters


- (NNTextView *)textView
{
    if (_textView == nil) {
        _textView = [[NNTextView alloc] init];
        _textView.delegate = self;
        _textView.placeholder = @"请简要描述您要申诉的内容";
        _textView.placeholderColor = [UIConfigManager colorTextLightGray];
    }
    return _textView;
}


- (NNHUploadPictureView *)pictureView
{
    if (_pictureView == nil) {
        _pictureView = [[NNHUploadPictureView alloc] initWithMaxImageCount:5];
        _pictureView.delegate = self;
    }
    return _pictureView;
}

@end
