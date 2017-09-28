//
//  SaveHeightWithStaticValueController.m
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import "SaveHeightWithStaticValueController.h"
#import "Defines.h"
#import "CustomCell.h"
#import "WorkModel.h"
#import "MJExtension.h"

@interface SaveHeightWithStaticValueController ()
@property (nonatomic, copy) NSArray *dataSources;
@end

@implementation SaveHeightWithStaticValueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path] ;
    self.dataSources = [WorkModel mj_objectArrayWithKeyValuesArray:dict[@"data"]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    [cell configData:self.dataSources[indexPath.row]];
    NSLog(@"------数据--%ld---=%f",indexPath.row,[CustomCell cellHeight]);
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"------高度--%ld---=%f",indexPath.row,[CustomCell cellHeight]);
    return [CustomCell cellHeight];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSources.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
