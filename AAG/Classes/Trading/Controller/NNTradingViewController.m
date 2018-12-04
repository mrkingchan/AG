//
//  NNTradingViewController.m
//  YWL
//
//  Created by 牛牛 on 2018/3/2.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           矿市模块 转资产
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNTradingViewController.h"
#import "NNHomeTopView.h"
#import "NNMineFundTransferViewController.h"
#import "NNPageContentView.h"
#import "NNTransferRecordListViewController.h"
#import "NNMineFundScanViewController.h"

@interface NNTradingViewController ()<NNHPageContentViewDelegare>

@property (nonatomic, strong) NNHomeTopView *topView;
/**  包含控制前视图 */
@property (nonatomic, strong) NNPageContentView *pageContentView;
/** 控制器数组 */
@property (nonatomic, strong) NSMutableArray *controllerArray;

@end

@implementation NNTradingViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupChildView];
}

- (void)setupChildView
{
    [self.view addSubview:self.topView];
    
    NNMineFundTransferViewController *listVC = [[NNMineFundTransferViewController alloc] init];
    [self.controllerArray addObject:listVC];
    
    NNMineFundScanViewController *scanVC = [[NNMineFundScanViewController alloc] init];
    [self.controllerArray addObject:scanVC];
    
    NNTransferRecordListViewController *recordVC = [[NNTransferRecordListViewController alloc] init];
    [self.controllerArray addObject:recordVC];
    

    CGFloat contentViewHeight = self.view.nnh_height - self.topView.nnh_height - self.tabBarController.tabBar.nnh_height;
    
    self.pageContentView = [[NNPageContentView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.frame.size.width, contentViewHeight) parentVC:self childVCs:self.controllerArray];
    self.pageContentView.scrollEnabled = NO;
    self.pageContentView.pageContentViewDelegate = self;
    [self.view addSubview:self.pageContentView];
}

#pragma mark - NNHPageContentViewDelegare
- (void)nnh_pageContentView:(NNPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex
{
    
}

#pragma mark -
#pragma mark ---------UserAction


#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHomeTopView *)topView
{
    if (_topView == nil) {
        _topView = [[NNHomeTopView alloc] initWithTitle:@"资产互转" detailTitles:@[@"转资产",@"收资产",@"清单"]];
        NNHWeakSelf(self)
        _topView.selectedSegmentIndexBlock = ^(NSInteger index) {
            [weakself.pageContentView setPageCententViewCurrentIndex:index];
            if (index != 1) {
                NNBaseViewController *recordVC = weakself.controllerArray[index];
                [recordVC loadNetworkData];
            }
        };
    }
    return _topView;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (NSMutableArray *)controllerArray
{
    if (_controllerArray == nil) {
        _controllerArray = [NSMutableArray array];
    }
    return _controllerArray;
}

@end
