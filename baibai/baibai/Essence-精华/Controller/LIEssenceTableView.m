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

@interface LIEssenceTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) AFHTTPSessionManager *manger;
/** 用来加载下一页数据 */
@property (nonatomic,strong) NSString *maxtime;

@property (nonatomic, strong) NSArray *list;

@end

@implementation LIEssenceTableView

- (instancetype) init{

    self = [super init];
    
    if (self) {
        self = [UIStoryboard storyboardWithName:@"LIEssenceTableView" bundle:nil].instantiateInitialViewController;
    }
    
    return self;
}

- (AFHTTPSessionManager *)manger{
    
    if (_manger == nil) {
        _manger = [AFHTTPSessionManager manager];
    }
    return  _manger;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadMore];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//上拉加载更多
- (void)loadMore{

    NSDictionary *dict = @{
                           @"a":@"list",
                           @"type":@"29",
                           @"c":@"data",
//                           @"maxtime":self.maxtime,
                           
                           };
    
    [self.manger GET:@"http://api.budejie.com/api/api_open.php" parameters:dict success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.list = [LIEssenceModel mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
//        NSLog(@"%@",responseObject);
        [self.tableView reloadData];
//        NSLog(@"%@",self.list);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
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
