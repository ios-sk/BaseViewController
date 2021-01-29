//
// BaseTableViewController.h
//
// Created on 2021/1/29
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *dataSource;

/// Frame 默认全部
- (CGRect)tableViewFrame;

/// tableView样式 默认为Grouped
- (UITableViewStyle)tableViewStyle;

/// 注册Cell
- (void)regTableViewCell;

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
