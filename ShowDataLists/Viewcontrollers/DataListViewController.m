//
//  DataListViewController.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "DataListViewController.h"
#import "DataCell.h"

@interface DataListViewController ()
{
}
@property(strong, nonatomic) NSMutableArray *datalists;

@end

@implementation DataListViewController

// MARK: Memory Management
- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    
}

// MARK: View LifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}

// MARK: Private Methods
- (void)setupTableView
{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

// MARK: TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"DataCell";
    DataCell * cell = (DataCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.descriptionLabel.text = @"Test String Test String Test String Test String Test String Test String Test String Test String ";
    cell.descriptionLabel.text =
    cell.titleLabel.text = @"hello world";
    return cell;
}

//MARK: TableView Delegates
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}
@end
