//
//  NNMineOperationRollView.m
//  YWL
//
//  Created by 来旭磊 on 2018/5/10.
//  Copyright © 2018年 超级钱包. All rights reserved.
//

#import "NNMineOperationRollView.h"
#import "NNMineOperationRollCell.h"
@interface NNMineOperationRollView ()<UITableViewDelegate,UITableViewDataSource>

/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/**定时器 */
@property (strong, nonatomic) CADisplayLink *displayLink;

@property (assign,nonatomic) int count;
/** 透明度 */
@property (nonatomic, assign) CGFloat alpha;
/** cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 滚动速度 */
@property (nonatomic, assign) CGFloat rollSpeed;
@end

@implementation NNMineOperationRollView
{
    CGFloat _totalHeight;
    BOOL _rollFlag;
}

- (void)dealloc
{
    NNHLog(@"------%s------",__func__);
}

- (instancetype)initWithCellHeight:(CGFloat)cellHeight rollSpeed:(CGFloat)rollSpeed alpha:(CGFloat)alpha;
{
    if (self = [super init]) {
        
        _cellHeight = cellHeight;
        _rollSpeed = rollSpeed;
        _alpha = alpha;
        _rollFlag = YES;
        [self setupChildView];
        
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.tableView.alpha = self.alpha;
    
    _totalHeight = self.dataSource.count * self.cellHeight - (SCREEN_HEIGHT) + (NNHNavBarViewHeight) + (NNHBottomSafeHeight);

    [self.tableView setContentOffset:CGPointMake(0, _totalHeight) animated:NO];

    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(rollAction)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];

}

- (void)rollAction
{
    if (_rollFlag) {
        self.count ++;
        [self.tableView setContentOffset:CGPointMake(0,  _totalHeight - self.count * self.rollSpeed) animated:NO];
    }
}

- (void)stop
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

#pragma mark -
#pragma mark ---------UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNMineOperationRollCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNMineOperationRollCell class])];
    cell.imageName = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.tableView setContentOffset:CGPointMake(0, _totalHeight) animated:NO];
        self.count = 0;
    }
}

#pragma mark - Lazy Loads

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.scrollEnabled = NO;
        _tableView.rowHeight = _cellHeight;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[NNMineOperationRollCell class] forCellReuseIdentifier:NSStringFromClass([NNMineOperationRollCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        NSString *name = @"nub_roll1";
        [_dataSource addObject:name];
        for (int i = 0; i < 100; i ++) {
            int a = i % 10;
            NSString *imageName = [NSString stringWithFormat:@"nub_roll%d",a];
            [_dataSource addObject:imageName];
        }
    }
    return _dataSource;
}

@end
