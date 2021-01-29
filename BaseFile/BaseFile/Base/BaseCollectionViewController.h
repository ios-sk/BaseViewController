//
// BaseCollectionViewController.h
//
// Created on 2021/1/29
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

/// Frame 默认全部
- (CGRect)collectionViewFrame;

- (void)regCollectionViewCell;

#pragma mark - 上下拉加载

/// 去掉上下拉刷新 列表默认添加 如不需要可调用该方法移除
- (void)removedRefreshing;

/// 下拉请求
- (void)refresh;

/// 加载更多
- (void)loadMore;


/// 结束刷新
/// @param isMore 是否有更多数据
- (void)endRefreshingWithIsHaveMoreData:(BOOL)isMore;

/// 隐藏加载更多
- (void)hideLoadMoreRefreshing;

/// 显示加载更多
- (void)showLoadMoreRefreshing;

/// 刷新数据
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
