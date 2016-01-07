//
//  MoreTableView.m
//  MyGame
//
//  Created by Mac_Tech on 15/10/29.
//  Copyright © 2015年 Mac_Tech. All rights reserved.
//

#import "MoreTableView.h"

@implementation MoreTableView


- (instancetype)initWithNull
{
    if(self = [super init])
    {
        [self showTableView];
    }
    return self;
};

-(void)showTableView
{
    self.frame = CGRectMake(0, 0, 300, 500);
    //
    UITableView *_tableView = [[UITableView alloc] initWithFrame:(CGRect){0,0,300,500}];
    //_tableView.rowHeight = 50;
    _tableView.delegate = self;
    [_tableView setDataSource:self];
    // 设置表视图的颜色
    //_tableView.backgroundColor = [UIColor yellowColor];
    // 设置表视图的分割线的颜色
    //_tableView.separatorColor = [UIColor purpleColor];
    [self addSubview:_tableView];
    //
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    headerView.backgroundColor = [UIColor redColor];
    UILabel *headText = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 40)];
    headText.text = @"警告⚠";
    headText.numberOfLines = 0;
    [headerView addSubview:headText];
    _tableView.tableHeaderView = headerView; //设置头部
    //_tableView.tableFooterView = footerView;  //设置尾部
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//创建一个cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        //cell的四种样式
        //UITableViewCellStyleDefault,       只显示图片和标题
        //UITableViewCellStyleValue1,        显示图片，标题和子标题（子标题在右边）
        //UITableViewCellStyleValue2,        标题和子标题
        //UITableViewCellStyleSubtitle       显示图片，标题和子标题（子标题在下边）
    }
    //设置标题字体颜色
    NSString* str = [[NSString alloc] initWithFormat:@"一个测试的: %i",(int)indexPath.section];
    cell.textLabel.text = str;
    cell.textLabel.textColor = [UIColor redColor];
    //设置标题字体大小
    cell.textLabel.font = [UIFont fontWithName:@"大宋" size:18];
    [cell.imageView setImage:[UIImage imageNamed:@"checkbox_selected.png"]];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 40)];
    label.text = @"厕所不是";
    [label setTextColor:[UIColor orangeColor]];
    [cell addSubview:label];
    return cell;
}


@end
