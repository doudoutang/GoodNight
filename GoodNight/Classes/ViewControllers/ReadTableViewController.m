//
//  ReadTableViewController.m
//  GoodNight
//
//  Created by lanou3g on 15/8/20.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ReadTableViewController.h"
#import "ReadTableViewCell.h"
#import "AFNetworking.h"
#import "ReadDetailViewController.h"
#import "MJRefresh.h"

#define kReadUrl @"http://jtbk.vipappsina.com/yulu/card21/article26.php?pad=0&markId="

@interface ReadTableViewController ()

@property (nonatomic, strong) NSMutableArray *readArray;


@property (nonatomic, assign) NSInteger readCount;

@end

@implementation ReadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ReadTableViewCell" bundle:nil] forCellReuseIdentifier:@"readCell"];
    
    self.navigationItem.title = @"美文欣赏";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    [refreshControl addTarget:self action:@selector(refreshControlStateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refreshControl];
    [refreshControl beginRefreshing];
    [self refreshControlStateChange:refreshControl];
    
    __weak ReadTableViewController *readTVC = self;
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [readTVC setUpRefresh];
    }];

    

}

- (void)setUpRefresh {
    //自动开始刷新
//    [self.tableView footerBeginRefreshing];
    
    Read *read = [self.readArray lastObject];
    NSInteger readIndex = [read.id integerValue] - 1;
    NSString *readId = [NSString stringWithFormat:@"%ld",readIndex];
    NSString *readUrl = [kReadUrl stringByAppendingString:readId];
    
    [[DataBase shareInstance] getReadDataWithUrl:readUrl result:^(id result) {
        
        if (result) {
            NSArray *array = result;
            for (NSDictionary *dict in array) {
                Read *readModel = [[Read alloc] init];
                [readModel setValuesForKeysWithDictionary:dict];
                [self.readArray addObject:readModel];
            }
            [self.tableView reloadData];
            [self.tableView.footer endRefreshing];
        }else {
            [self.tableView.footer endRefreshing];
        }
        
        
    }];

    
}

- (void)refreshControlStateChange:(UIRefreshControl *)refreshControl {
    //解析数据
    
    [[DataBase shareInstance] getReadDataWithUrl:@"http://jtbk.vipappsina.com/yulu/card21/article26.php?pad=0&markId=0" result:^(id result) {
        
        if (result) {
            NSArray *array = result;
            for (NSDictionary *dict in array) {
                Read *readModel = [[Read alloc] init];
                [readModel setValuesForKeysWithDictionary:dict];
                [self.readArray addObject:readModel];
            }
            [refreshControl endRefreshing];
            [self.tableView reloadData];
        }else {
            [refreshControl endRefreshing];
        }
        
    }];
    
    /*
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    
//    NSString *url = [@"http://jtbk.vipappsina.com/yulu/card21/article26.php?pad=0&markId=0" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    
//    manager.securityPolicy.allowInvalidCertificates = YES;
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
//        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSArray *array = result;
//        for (NSDictionary *dict in array) {
//            Read *readModel = [[Read alloc] init];
//            [readModel setValuesForKeysWithDictionary:dict];
//            [self.readArray addObject:readModel];
//        }
//        
//        [self.tableView reloadData];
//        [refreshControl endRefreshing];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"function == %s  line == %d  error == %@",__FUNCTION__,__LINE__,error);
//        [refreshControl endRefreshing];
//    }];
*/
    
}

#pragma mark - 阅读数组懒加载
- (NSMutableArray *)readArray {
    if (!_readArray) {
        self.readArray = [NSMutableArray array];
    }
    return _readArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.readArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"readCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    Read *read = self.readArray[indexPath.row];
    cell.titleLable.text = read.title;
    cell.timeLable.text = read.cTime;
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:read.pic]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 270;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ReadDetailViewController *readDetailVC = [[ReadDetailViewController alloc] init];
    
    
    Read *read = self.readArray[indexPath.row];
    readDetailVC.read = read;
    
    [self.navigationController pushViewController:readDetailVC animated:YES];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
