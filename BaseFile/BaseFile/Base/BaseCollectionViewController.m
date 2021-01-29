//
// BaseCollectionViewController.m
//
// Created on 2021/1/29
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@property (nonatomic,strong) MJRefreshNormalHeader *header;
@property (nonatomic,strong) MJRefreshBackNormalFooter *footer;

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    
    [self collectionViewBasicSet];
    [self regCollectionViewCell];
    [super viewDidLoad];
    [self header];
    [self footer];
    
    kWeakSelf(self);
    self.collectionView.retryBlock = ^{
        [weakself refresh];
    };
    
}

#pragma --  initCollectionView
- (void)collectionViewBasicSet{
    UICollectionViewFlowLayout *layout= [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:[self collectionViewFrame] collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    if (kiOS(11.0)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
}

/// Frame 默认全部
- (CGRect)collectionViewFrame{
    return CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (void)regCollectionViewCell{
    
}

#pragma mark - 上下拉加载
/// 去掉上下拉刷新 列表默认添加 如不需要可调用该方法移除
- (void)removedRefreshing{
    _header = nil;
    _footer = nil;
    self.collectionView.mj_header = nil;
    self.collectionView.mj_footer = nil;
}

/// 下拉请求
- (void)refresh{
    self.pageIndex = 0;
    [self requestData];
}

/// 加载更多
- (void)loadMore{
    self.pageIndex ++;
    [self requestData];
}

/// 结束刷新
/// @param isMore 是否有更多数据
- (void)endRefreshingWithIsHaveMoreData:(BOOL)isMore{
    if (_header) {
        [self.header endRefreshing];
    }
    if (_footer) {
        if (isMore) {
            [_footer endRefreshing];
        }else{
            [_footer  endRefreshingWithNoMoreData];
        }
    }
}

/// 隐藏加载更多
- (void)hideLoadMoreRefreshing{
    self.collectionView.mj_footer = nil;
    _footer = nil;
}

/// 显示加载更多
- (void)showLoadMoreRefreshing{
    if (!_footer) {
        [self footer];
    }
}

/// 刷新数据
- (void)refreshData{
    [self.collectionView reloadData];
}

- (MJRefreshNormalHeader *)header {
    if (!_header) {
        __weak __typeof(self)weakSelf = self;
        _header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            __strong __typeof(self)self = weakSelf;
            [self refresh];
        }];
        self.collectionView.mj_header = _header;
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
        self.collectionView.mj_footer = _footer;
    }
    return [self setRefreshBackNormalFooterParameter:_footer];
}

#pragma mark UICollectionViewDataSource/UICollectionViewDelegate
//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"BaseCollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(50, 50);
}

//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Lazy
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end
