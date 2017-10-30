//
//  DataListViewController.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "DataListViewController.h"
#import "DataCell.h"
#import "DataManager.h"

@interface DataListViewController ()
{
}
@property(strong, nonatomic) NSMutableArray *datalists;
@property(strong, nonatomic) DataManager *managerObj;
@property(strong, nonatomic) NSString *title;

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
    [self getServerData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveDataObjects:)
                                                 name:@"LOADLIST_NOTIFICATION"
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"LOADLIST_NOTIFICATION" object:nil];
}

// MARK: Private Methods
- (void)setupTableView
{
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)getServerData
{
    _managerObj = [[DataManager alloc] init];
    [_managerObj getServerData];
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
//MARK: Notification Handlers

- (void)receiveDataObjects:(NSNotification *) notification
{
    NSMutableDictionary *dict = (NSMutableDictionary *)notification.object;
}
@end
