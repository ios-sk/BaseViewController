//
// BaseTableViewController.m
//
// Created on 2021/1/29
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@property (nonatomic, strong) MJRefreshNormalHeader *header;
@property (nonatomic, strong) MJRefreshBackNormalFooter *footer;

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    
    [self initTableViewStyle];
    [self tableViewBasicSet];
    [self regTableViewCell];
    [super viewDidLoad];
    [self header];
    [self footer];
    
    kWeakSelf(self);
    self.tableview.retryBlock = ^{
        [weakself refresh];
    };
    
}

#pragma --  initTableView
- (void)initTableViewStyle{
    self.tableview = [[UITableView alloc] initWithFrame:[self tableViewFrame] style:[self tableViewStyle]];
}

- (void)tableViewBasicSet{
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    if (kiOS(11.0)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.tableview.estimatedRowHeight = 0;
    self.tableview.estimatedSectionHeaderHeight = 0;
    self.tableview.estimatedSectionFooterHeight = 0;
    self.tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableview];
    [self.view sendSubviewToBack:self.tableview];
}

- (void)regTableViewCell{
    
}

- (CGRect)tableViewFrame{
    return CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (UITableViewStyle)tableViewStyle{
    return UITableViewStyleGrouped;
}

#pragma mark UITableViewDataSource/UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * tableViewCellIdentifier = @"BaseTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}

#pragma mark - refreshData

/**
 *  刷新tableView
 */
- (void)refreshData {
    [self.tableview reloadData];
}


#pragma mark - MJRefresh上下拉加载
- (void)refresh {
    self.pageIndex = 0;
    [self requestData];
}

- (void)loadMore {
    self.pageIndex ++;
    [self requestData];
}

- (void)endRefreshingWithIsHaveMoreData:(BOOL)isMore{
    if (_header) {
        [_header endRefreshing];
    }
    
    if (_footer) {
        if (isMore) {
            [_footer endRefreshing];
        }else{
            [_footer endRefreshingWithNoMoreData];
        }
    }
}

- (void)removedRefreshing {
    _header = nil;
    _footer = nil;
    self.tableview.mj_header = nil;
    self.tableview.mj_footer = nil;
}

- (void)showLoadMoreRefreshing {
    if (!_footer) {
        [self footer];
    }
}

- (void)hideLoadMoreRefreshing {
    self.tableview.mj_footer = nil;
    _footer = nil;
}

- (MJRefreshNormalHeader *)header {
    if (!_header) {
        __weak __typeof(self)weakSelf = self;
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong __typeof(self)self = weakSelf;
            [self refresh];
        }];
        self.tableview.mj_header = _header;
    }
    return [self setRefreshNormalHeaderParameter:_header];
}

- (MJRefreshBackNormalFooter *)footer {
    if (!_footer) {
        __weak __typeof(self)weakSelf = self;
        _footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            __strong __typeof(self)self = weakSelf;
            [self loadMore];
        }];
        self.tableview.mj_footer = _footer;
        
    }
    return [self setRefreshBackNormalFooterParameter:_footer];
}

#pragma mark - Lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

@end
