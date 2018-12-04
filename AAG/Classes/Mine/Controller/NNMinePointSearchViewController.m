//
//  NNMinePointSearchViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/7/9.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMinePointSearchViewController.h"
#import "NNAPIBlockPointTool.h"

@interface NNMinePointSearchViewController ()

/** 搜索框 */
@property (nonatomic, weak) UITextField *searchField;
/** 搜索view */
@property (nonatomic, strong) UIView *searchView;
/** 接点内容view */
@property (nonatomic, strong) UIView *ponitContentView;

@end

@implementation NNMinePointSearchViewController
{
    BOOL _isShowSearch;
}

#pragma mark - Life Cycle Methods
- (instancetype)initWithShowSearch:(BOOL)showSearch
{
    if (self = [super init]) {
        _isShowSearch = showSearch;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"接点查询";
    
    [self setupChildView];
    [self requestPointDataSource];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [self.view addSubview:self.ponitContentView];
    [self.ponitContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
}

#pragma mark - Network Methods
- (void)requestPointDataSource
{
    NSString *username = self.searchField.text.length ? self.searchField.text : [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.username;
    NNHWeakSelf(self)
    NNAPIBlockPointTool *searchTool = [[NNAPIBlockPointTool alloc] initSearchNodeWithNodeAccount:username];
    [searchTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NSArray *pointArr = responseDic[@"data"][@"nodelist"];
        if (pointArr.count> 0) {
            [weakself updatePointDataSource:pointArr];
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Target Methods

- (void)searchButtonAction
{
    if (!self.searchField.hasText) {
        [SVProgressHUD showMessage:@"请输入接点账号"];
        return;
    }
    
    [self requestPointDataSource];
}

- (void)updatePointDataSource:(NSArray *)pointValueArr
{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSInteger i = 0; i < self.ponitContentView.subviews.count; i++) {
        id object = self.ponitContentView.subviews[i];
        if ([object isKindOfClass:[UIButton class]]) {
            [mArray addObject:object];
        }
    }
    
    for (NSInteger i = 0; i < mArray.count; i++) {
        UIButton *btn = mArray[i];
        [btn setTitle:pointValueArr[i] forState:UIControlStateNormal];
    }
}

#pragma mark - Lazy Loads
- (UIView *)searchView
{
    if (_searchView == nil) {
        _searchView = [[UIView alloc] init];
        _searchView.backgroundColor = [UIConfigManager colorThemeWhite];
        _searchView.hidden = !_isShowSearch;
        
        UITextField *searchField = [[UITextField alloc] init];
        searchField.font = [UIConfigManager fontThemeTextDefault];
        searchField.placeholder = @"请输入要查询的接点账号";
        searchField.keyboardType = UIKeyboardTypeWebSearch;
        [_searchView addSubview:searchField];
        _searchField = searchField;
        [searchField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_searchView);
            make.left.equalTo(_searchView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 100));
            make.height.equalTo(@(28));
        }];
        
        UIButton *searchButton = [UIButton NNHBtnTitle:@"搜索" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor akext_colorWithHex:@"#d1d1da"] titleColor:[UIConfigManager colorThemeRed]];
        searchButton.adjustsImageWhenHighlighted = NO;
        [searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
        NNHViewRadius(searchButton, 5);
        [_searchView addSubview:searchButton];
        [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_searchView).offset(-NNHMargin_15);
            make.centerY.equalTo(_searchView);
            make.size.mas_equalTo(CGSizeMake(60, 30));
        }];
    }
    return _searchView;
}

- (UIView *)ponitContentView
{
    if (_ponitContentView == nil) {
        _ponitContentView = [[UIView alloc] init];
        _ponitContentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        CGFloat btnW = (SCREEN_WIDTH - 60) / 4;
        CGFloat btnH = 30;
        UIButton *oneButton = [self createPointLocation];
        [oneButton setBackgroundColor:[UIColor akext_colorWithHex:@"#d1d1da"] forState:UIControlStateNormal];
        NNHViewRadius(oneButton, 20);
        [_ponitContentView addSubview:oneButton];
        [oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_ponitContentView).offset(50);
            make.centerX.equalTo(_ponitContentView);
            make.size.mas_equalTo(CGSizeMake(btnW, btnH + 10));
        }];
        
        UIButton *twoButton = [self createPointLocation];
        [_ponitContentView addSubview:twoButton];
        [twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneButton.mas_bottom).offset(30);
            make.right.equalTo(_ponitContentView.mas_centerX).offset(-15);
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
        }];
        
        UIButton *threeButton = [self createPointLocation];
        [_ponitContentView addSubview:threeButton];
        [threeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoButton);
            make.left.equalTo(_ponitContentView.mas_centerX).offset(15);
            make.size.equalTo(twoButton);
        }];
        
        UIImageView *oneLineView = [[UIImageView alloc] initWithImage:ImageName(@"ic_mine_pointLine")];
        [_ponitContentView addSubview:oneLineView];
        [oneLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(oneButton.mas_bottom).offset(15);
            make.left.equalTo(twoButton.mas_centerX);
            make.right.equalTo(threeButton.mas_centerX);
            make.bottom.equalTo(twoButton.mas_top);
        }];
        
        UIButton *fourButton = [self createPointLocation];
        [_ponitContentView addSubview:fourButton];
        [fourButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoButton.mas_bottom).offset(30);
            make.left.equalTo(_ponitContentView).offset(15);
            make.size.equalTo(twoButton);
        }];
        
        UIButton *fiveButton = [self createPointLocation];
        [_ponitContentView addSubview:fiveButton];
        [fiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fourButton);
            make.left.equalTo(fourButton.mas_right).offset(5);
            make.size.equalTo(twoButton);
        }];
        
        UIButton *sixButton = [self createPointLocation];
        [_ponitContentView addSubview:sixButton];
        [sixButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fourButton);
            make.left.equalTo(_ponitContentView.mas_centerX).offset(10);
            make.size.equalTo(twoButton);
        }];
        
        UIButton *sevenButton = [self createPointLocation];
        [_ponitContentView addSubview:sevenButton];
        [sevenButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(fourButton);
            make.right.equalTo(_ponitContentView).offset(-15);
            make.size.equalTo(twoButton);
        }];
        
        UIImageView *twoLineView = [[UIImageView alloc] initWithImage:ImageName(@"ic_mine_pointLine")];
        [_ponitContentView addSubview:twoLineView];
        [twoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(twoButton.mas_bottom).offset(15);
            make.left.equalTo(fourButton.mas_centerX);
            make.right.equalTo(fiveButton.mas_centerX);
            make.bottom.equalTo(fourButton.mas_top);
        }];

        UIImageView *threeLineView = [[UIImageView alloc] initWithImage:ImageName(@"ic_mine_pointLine")];
        [_ponitContentView addSubview:threeLineView];
        [threeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(twoLineView);
            make.left.equalTo(sixButton.mas_centerX);
            make.right.equalTo(sevenButton.mas_centerX);
        }];
    }
    return _ponitContentView;
}

- (UIButton *)createPointLocation
{
    UIButton *button = [UIButton NNHBorderBtnTitle:@"无" borderColor:[UIConfigManager colorThemeRed] titleColor:[UIConfigManager colorThemeRed]];
    [button setBackgroundColor:[UIColor akext_colorWithHex:@"#d1d1da"] forState:UIControlStateNormal];
    [button setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIConfigManager fontThemeTextMinTip]];
    button.titleLabel.numberOfLines = 0;
    button.adjustsImageWhenHighlighted = NO;
    NNHViewRadius(button, 15);
    return button;
}

@end

