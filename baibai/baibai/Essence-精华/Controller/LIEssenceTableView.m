//
//  LIEssenceTableView.m
//  baibai
//
//  Created by litoyo on 16/9/17.
//  Copyright © 2016年 litoyo. All rights reserved.
//

#import "LIEssenceTableView.h"
#import "LICellTableViewCell.h"
#import "AFNetWorking.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "LIEssenceModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Image.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface LIEssenceTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 用来加载下一页数据 */
@property (nonatomic,strong) NSString *maxtime;

//保存所有帖子的数据
@property (nonatomic,strong) NSMutableArray *topics;

@property (nonatomic, strong) NSMutableArray *list;

@property (nonatomic, strong) UIView *cover;

@end

@implementation LIEssenceTableView

- (instancetype) init{

    self = [super init];
    
    if (self) {
        self = [UIStoryboard storyboardWithName:@"LIEssenceTableView" bundle:nil].instantiateInitialViewController;
    }
    
    return self;
}

- (AFHTTPSessionManager *)manager{
    
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return  _manager;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刚进去页面就下拉刷新
//    [self loadNewData];
    //下拉刷新
    [self XiaLaShuaXin];
    //上拉加载更多
    [self ShangLaShuaXin];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//下拉刷新
- (void)XiaLaShuaXin{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    // Set font
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    // Set textColor
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.mj_header = header;
}

//上拉刷新

- (void)ShangLaShuaXin{

    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    // Set the normal state of the animated image
    [footer setTitle:@"上拉刷新" forState:MJRefreshStateIdle];
    [footer setTitle:@"释放刷新" forState:MJRefreshStatePulling];
    [footer setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    // Set footer
    self.tableView.mj_footer = footer;
    
//     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"MainTagSubIconClick"] style:UIBarButtonItemStylePlain target:self action:@selector(activity)];
}


//下拉数据请求
- (void)loadNewData{
    NSLog(@"123");
    
    NSDictionary *dict = @{
                           @"a":@"list",
                           @"type":@"29",
                           @"c":@"data",
                           };
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.list = [LIEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //取出info中的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
//        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];

    }];

}

//上拉数据请求
- (void)loadMoreData{
    NSLog(@"123");
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"a"] = @"list";
    parameters[@"type"] = @"29";
    parameters[@"c"] = @"data";
    parameters[@"maxtime"] = self.maxtime;
    
    //发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        [responseObject writeToFile:@"/Users/litoyo/Desktop/qp.plist" atomically:YES];
        
        //取出info中的maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        
        //字典转模型
         NSArray *moreTopics = [LIEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        //======================重要=========================
        //下拉刷新是替换数组,上拉刷新是替换数组,如果想优化不等高cell,可以缓存高度.
        [self.list addObjectsFromArray:moreTopics];
        
        //刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 每当scrollView滚动, 就清除内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LICellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LICellTableViewCell" forIndexPath:indexPath];
    LIEssenceModel *model = self.list[indexPath.row];
    
    [cell.touxiang sd_setImageWithURL:[NSURL URLWithString:model.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    cell.mingchen.text = model.name;
    cell.neirong.text = model.text;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 模型数据
    
    LIEssenceModel *model = self.list[indexPath.row];
    return model.cellHeight;
}


@end
