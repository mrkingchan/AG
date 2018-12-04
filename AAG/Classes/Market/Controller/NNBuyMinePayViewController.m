//
//  NNBuyMinePayViewController.m
//  NBTMill
//
//  Created by 来旭磊 on 2018/5/3.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNBuyMinePayViewController.h"
#import "NNBuyMineHistoryViewController.h"

#import "NNHApiMarketHomeTool.h"
#import "NNBuyMinePayMethodModel.h"
#import "NNHMineBuyModel.h"
#import "NNHMineModel.h"
#import "NNHomeListModel.h"

#import "NNHEnterPasswordView.h"
#import "NNBuyMinePayMethodCell.h"
#import "NNHAmountChangeButton.h"
#import "NNBuyMinePayMethodModel.h"

@interface NNBuyMinePayViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 支付列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 支付方式 当前选中行 */
@property (nonatomic, strong) NSIndexPath *currentIndex;
/** tableView头部试图 */
@property (nonatomic, strong) UIView *payHeaderView;
/** tableView尾部试图 */
@property (nonatomic, strong) UIView *payFooterView;
/** 输入密码 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 矿机名称 */
@property (nonatomic, strong) UIView *nameView;
/** 购买矿机名称 */
@property (nonatomic, strong) UILabel *mineNameLabel;
/** 购买矿机数量view */
@property (nonatomic, strong) UIView *countView;
/** 购买矿机数量 */
@property (nonatomic, strong) UILabel *mineCountLabel;
/** 支付确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 支付说明 */
@property (nonatomic, strong) UILabel *payMessageLabel;
/** 数量修改按钮 */
@property (nonatomic, strong) NNHAmountChangeButton *countButton;

/** 列表带过来的模型 */
@property (nonatomic, strong) NNHomeListModel *homeModel;
/** 购机数量 */
@property (nonatomic, copy) NSString *totalCount;

/** 购机数据模型 */
@property (nonatomic, strong) NNHMineBuyModel *mineModel;

@end

@implementation NNBuyMinePayViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

/**
 初始化方法
 
 @param homeModel 数据模型
 @return api
 */
- (instancetype)initWithHomeModel:(NNHomeListModel *)homeModel
{
    if (self = [super init]) {
        _homeModel = homeModel;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"付款";
    [self setupChildView];
    
    [self requestMineData];
    
//    UIBarButtonItem *rightItem = [UIBarButtonItem itemWithTarget:self action:@selector(rightItemAction) title:@"购机记录"];
//    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage nnh_imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor],
                                                                    NSFontAttributeName:[UIFont systemFontOfSize:18]};
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mineModel.paymethod.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNBuyMinePayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNBuyMinePayMethodCell class ])];
    
    NNBuyMinePayMethodModel *payMethodModel = self.mineModel.paymethod[indexPath.row];
    
    if (indexPath.row == 0 && !self.currentIndex) {
        payMethodModel.selectedFalg = YES;
        self.currentIndex = indexPath;
    }
    
    cell.payMethodModel = payMethodModel;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex) {
        NNBuyMinePayMethodCell *oldCell = [tableView cellForRowAtIndexPath:self.currentIndex];
        oldCell.payMethodModel.selectedFalg = NO;
    }
    
    NNBuyMinePayMethodCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.payMethodModel.selectedFalg = YES;
    self.currentIndex = indexPath;
    
    [self.tableView reloadData];
}

#pragma mark - Network Methods

- (void)requestMineData
{
    NNHWeakSelf(self)
    NNHApiMarketHomeTool *mineTool = [[NNHApiMarketHomeTool alloc] initBuyMineDataWithMineID:self.homeModel.ID];
    [mineTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself handleMineWithData:responseDic];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)handleMineWithData:(NSDictionary *)responseDic
{
    self.mineModel = [NNHMineBuyModel mj_objectWithKeyValues:responseDic[@"data"]];
    self.mineNameLabel.text = self.mineModel.mine.name;
    self.payMessageLabel.text = self.mineModel.mine.content;
    self.mineCountLabel.text = self.mineModel.mine.ltc_num;
    [self.tableView reloadData];
    
    self.totalCount = self.mineModel.mine.ltc_num;

}

/** 输入交易密码 */
- (void)inputPayCode:(NSString *)paycode
{
    NNBuyMinePayMethodModel *payMethodModel = self.mineModel.paymethod[self.currentIndex.row];
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:nil];
    NNHApiMarketHomeTool *marketTool = [[NNHApiMarketHomeTool alloc] initBuyMinePayOrderWithMineID:self.homeModel.ID minetype:payMethodModel.paytype iscomput:self.homeModel.iscomput num:self.totalCount paypassword:paycode];
    [marketTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.enterView dissmissWithCompletion:nil];
        [SVProgressHUD showMessage:@"购买成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^(NNHRequestError *error) {
        [weakself.enterView resetStatus];
    } isCached:NO];
}

#pragma mark - Target Methods

//- (void)rightItemAction
//{
//    NNBuyMineHistoryViewController *historyVC = [[NNBuyMineHistoryViewController alloc] init];
//    [self.navigationController pushViewController:historyVC animated:YES];
//}

/** 修改显示应付金额 */
- (void)changePayAmountWithCount:(NSInteger)count
{
    NSInteger num = [self.mineModel.mine.ltc_num integerValue];
    
    NSInteger total = num * count;
    
    self.totalCount = [NSString stringWithFormat:@"%zd",total];
    
    self.mineCountLabel.text = self.totalCount;
}

/** 点击购买按钮 */
- (void)clickEnsureButton:(UIButton *)button
{
    [self.enterView showInFatherView:self.view];
}

#pragma mark - Public Methods


#pragma mark - Private Methods

#pragma mark - Lazy Loads

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        _tableView.contentInset = UIEdgeInsetsMake(NNHMargin_10, 0, 0, 0);
        [_tableView registerClass:[NNBuyMinePayMethodCell class] forCellReuseIdentifier:NSStringFromClass([NNBuyMinePayMethodCell class])];
        _tableView.tableHeaderView = self.payHeaderView;
        _tableView.tableFooterView = self.payFooterView;
    }
    return _tableView;
}

- (UIView *)payHeaderView
{
    if (_payHeaderView == nil) {
        _payHeaderView = [[UIView alloc] init];
        _payHeaderView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _payHeaderView.frame = CGRectMake(0, 0, SCREEN_HEIGHT, 80 + 88 + 35);
        
        [_payHeaderView addSubview:self.nameView];
        [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_payHeaderView);
            make.top.equalTo(_payHeaderView).offset(NNHMargin_10);
            make.height.equalTo(@(NNHNormalViewH));
        }];
        
        [_payHeaderView addSubview:self.countView];
        [self.countView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(_payHeaderView);
            make.height.equalTo(@(104));
            make.top.equalTo(self.nameView.mas_bottom).offset(10);
        }];
        
        UILabel *messageLabel = [UILabel NNHWithTitle:@"请选择一种支付方式" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        [_payHeaderView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_payHeaderView).offset(NNHMargin_15);
            make.bottom.equalTo(_payHeaderView);
            make.height.equalTo(@(35));
        }];
    }
    return _payHeaderView;
}

- (UIView *)nameView
{
    if (_nameView == nil) {
        _nameView = [[UIView alloc] init];
        _nameView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"矿机类型" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_nameView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_nameView).offset(NNHMargin_15);
            make.centerY.equalTo(_nameView);
        }];
        
        [_nameView addSubview:self.mineNameLabel];
        [self.mineNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_20);
            make.centerY.equalTo(titleLabel);
        }];
    }
    return _nameView;
}

- (UILabel *)mineNameLabel
{
    if (_mineNameLabel == nil) {
        _mineNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _mineNameLabel;
}

- (UIView *)countView
{
    if (_countView == nil) {
        _countView = [[UIView alloc] init];
        _countView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *titleLabel = [UILabel NNHWithTitle:@"购买数量" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        [_countView addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.top.equalTo(_countView);
            make.height.equalTo(@(60));
        }];
        
        [_countView addSubview:self.mineCountLabel];
        [self.mineCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_20);
            make.centerY.equalTo(titleLabel);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        [_countView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.right.equalTo(_countView).offset(-NNHMargin_15);
            make.height.equalTo(@(NNHLineH));
            make.bottom.equalTo(titleLabel.mas_bottom);
        }];
        
        UILabel *messageLabel = [UILabel NNHWithTitle:@"请选择倍数：" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        [_countView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_countView).offset(NNHMargin_15);
            make.bottom.equalTo(_countView);
            make.height.equalTo(@(NNHNormalViewH));
        }];
        
        [_countView addSubview:self.countButton];
        [self.countButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(110));
            make.height.equalTo(@(30));
            make.centerY.equalTo(messageLabel);
            make.left.equalTo(messageLabel.mas_right).offset(NNHMargin_15);
        }];
        
    }
    return _countView;
}

- (UILabel *)mineCountLabel
{
    if (_mineCountLabel == nil) {
        _mineCountLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIFont systemFontOfSize:30]];
    }
    return _mineCountLabel;
}

- (NNHAmountChangeButton *)countButton
{
    if (_countButton == nil) {
        _countButton = [[NNHAmountChangeButton alloc] init];
        _countButton.currentNumber = 1;
        _countButton.minValue = 1;
        NNHWeakSelf(self)
        _countButton.resultBlock = ^(NSInteger number){
            [weakself changePayAmountWithCount:number];
        };
    }
    return _countButton;
}


- (UIView *)payFooterView
{
    if (_payFooterView == nil) {
        _payFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80 + NNHNormalViewH)];
        
        [_payFooterView addSubview:self.payMessageLabel];
        [self.payMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_payFooterView).offset(NNHMargin_10);
            make.left.equalTo(_payFooterView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 30));
        }];
        
        [_payFooterView addSubview:self.ensureButton];
        [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_payFooterView);
            make.left.equalTo(_payFooterView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 30));
            make.height.equalTo(@(NNHNormalViewH));
        }];
    }
    return _payFooterView;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"支付购买" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeBlue isAddCornerRadius:YES];
        _ensureButton.nn_acceptEventInterval = 1;
    }
    return _ensureButton;
}

- (UILabel *)payMessageLabel
{
    if (_payMessageLabel == nil) {
        _payMessageLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
        _payMessageLabel.numberOfLines = 0;
    }
    return _payMessageLabel;
}


- (NNHEnterPasswordView *)enterView
{
    if (_enterView == nil) {
        _enterView = [[NNHEnterPasswordView alloc] init];
        NNHWeakSelf(self)
        _enterView.didEnterCodeBlock = ^(NSString *password){
            NNHStrongSelf(self)
            [strongself inputPayCode:password];
        };
    }
    
    return _enterView;
}


@end
