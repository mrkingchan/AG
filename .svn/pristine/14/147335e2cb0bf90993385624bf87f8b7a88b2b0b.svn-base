//
//  NNCoinChartViewController.m
//  SuperWallet
//
//  Created by 牛牛 on 2018/3/28.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNCoinChartViewController.h"
#import "NNCoinChartView.h"
#import "NNCoinChartTopView.h"
#import "NNKLineGroupModel.h"
#import "NNHAPITradingTool.h"
#import "NNCoinMarketModel.h"
#import "NNHApplicationHelper.h"
#import "NNCoinChartOperationView.h"

@interface NNCoinChartViewController () <Y_StockChartViewDataSource>

/** 行情 */
@property (nonatomic, strong) NNCoinChartTopView *topView;
/** 折线图 */
@property (nonatomic, strong) NNCoinChartView *stockChartView;
/** 行情模型 */
@property (nonatomic, strong) NNCoinMarketModel *marketModel;
/** 折线模型 */
@property (nonatomic, strong) NNKLineGroupModel *groupModel;
/** 折线数据 */
@property (nonatomic, strong) NSMutableDictionary <NSString*, NNKLineGroupModel*> *modelsDict;
/** 当前默认选中 */
@property (nonatomic, assign) NSInteger currentIndex;
/** 当前默认类型 */
@property (nonatomic, copy) NSString *selectedType;
/** 当前选中时间 */
@property (nonatomic, copy) NSString *selectedTime;
/** 定时器 */
@property (nonatomic, strong) dispatch_source_t timer;
/** 底部操作控件 */
@property (nonatomic, strong) NNCoinChartOperationView *operationView;

@end

@implementation NNCoinChartViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    NNHLog(@"------%s-----",__func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 获取头部数据
    [self requestCoinDataSource];
    
    // 开启定时器
    dispatch_resume(self.timer);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 关闭定时器
    dispatch_source_cancel(self.timer);
    self.timer = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];

}

- (void)setupChildView
{
    [self.view addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@60);
    }];
    
    [self.view addSubview:self.operationView];
    [self.operationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(60));
    }];
    
    [self.view addSubview:self.stockChartView];
    [self.stockChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.operationView.mas_top);
    }];
}

- (void)requestCoinDataSource
{
    NNHAPITradingTool *tool = [[NNHAPITradingTool alloc] initNewCoinMarket];
    NNHWeakSelf(self)
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.marketModel = [NNCoinMarketModel mj_objectWithKeyValues:responseDic[@"data"][@"nbt_price"]];
        weakself.topView.marketModel = weakself.marketModel;
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UserAction

#pragma mark -
#pragma mark ---------Y_StockChartViewDataSource
- (id)stockDatasWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:{
            self.selectedType = @"1min";
            self.selectedTime = @"1";
        }
            break;
        case 1:{
            self.selectedType = @"1min";
            self.selectedTime = @"1";
        }
            break;
        case 2:{
            self.selectedType = @"1min";
            self.selectedTime = @"1";
        }
            break;
        case 3:{
            self.selectedType = @"30min";
            self.selectedTime = @"30";
        }
            break;
        case 4:{
            self.selectedType = @"1day";
            self.selectedTime = @"1440";
        }
            break;
        case 5:{
            self.selectedType = @"1week";
            self.selectedTime = @"10080";
        }
            break;
            
        default:
            break;
    }
    
    self.currentIndex = index;
    if(![self.modelsDict objectForKey:self.selectedType]){
        [self reloadDataWithTime:self.selectedTime];
    } else {
        return [self.modelsDict objectForKey:self.selectedType].models;
    }
    return nil;
}

- (void)reloadDataWithTime:(NSString *)time
{
    time = @"30";
    NNHAPITradingTool *tool = [[NNHAPITradingTool alloc] initCoinChartWithPeriod:time];
    NNHWeakSelf(self)
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NSArray *arr = responseDic[@"data"][@"list"];
        if (arr.count < 8) return;
        weakself.groupModel = [NNKLineGroupModel objectWithArray:arr];
        [weakself.modelsDict setObject:weakself.groupModel forKey:weakself.selectedType];
        [weakself.stockChartView reloadData];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NSMutableDictionary<NSString *,NNKLineGroupModel *> *)modelsDict
{
    if (_modelsDict == nil) {
        _modelsDict = [NSMutableDictionary dictionary];
    }
    return _modelsDict;
}

- (NNCoinChartTopView *)topView
{
    if (_topView == nil) {
        _topView = [[NNCoinChartTopView alloc] init];
    }
    return _topView;
}

- (NNCoinChartView *)stockChartView
{
    if(!_stockChartView) {
        _stockChartView = [[NNCoinChartView alloc] init];
        _stockChartView.itemModels = @[
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"指标" type:Y_StockChartcenterViewTypeOther],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"分时" type:Y_StockChartcenterViewTypeTimeLine],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"1分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"30分" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"日线" type:Y_StockChartcenterViewTypeKline],
                                       [Y_StockChartViewItemModel itemModelWithTitle:@"周线" type:Y_StockChartcenterViewTypeKline]
                                       ];
        _stockChartView.dataSource = self;
    }
    return _stockChartView;
}

- (dispatch_source_t)timer
{
    if (_timer == nil) { // 定时刷新
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 10.0 * NSEC_PER_SEC, 0);
        NNHWeakSelf(self)
        dispatch_source_set_event_handler(_timer, ^{
            [weakself requestCoinDataSource];
            [weakself reloadDataWithTime:weakself.selectedTime];
        });
    }
    return _timer;
}

- (NNCoinChartOperationView *)operationView
{
    if (_operationView == nil) {
        _operationView = [[NNCoinChartOperationView alloc] init];
        NNHWeakSelf(self)
        _operationView.operationBlock = ^(NSInteger tag) {
            if (weakself.operationActionBlock) {
                weakself.operationActionBlock(tag);
            }
        };
        
    }
    return _operationView;
}

@end
