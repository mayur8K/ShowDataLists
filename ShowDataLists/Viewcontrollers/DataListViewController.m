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
#import "DataModel.h"

@interface DataListViewController ()
{
    UIRefreshControl *refreshControl;
    DataCell * cell;
}
@property(strong, nonatomic) NSMutableArray *datalists;
@property(strong, nonatomic) DataManager *managerObj;
@property(strong, nonatomic) NSString *navTitle;


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
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor clearColor];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self
                       action:@selector(refreshViews)
             forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)getServerData
{
    _managerObj = [[DataManager alloc] init];
    [_managerObj getServerData];
}

- (void)refreshViews{
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

// MARK: TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datalists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"DataCell";
    cell = (DataCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(([(DataModel *)[self.datalists objectAtIndex:indexPath.row] descriptionTitle]) != (id)[NSNull null])
    {
        cell.descriptionLabel.text = [(DataModel *)[self.datalists objectAtIndex:indexPath.row] descriptionTitle];
    }
    
    if([(DataModel *)[self.datalists objectAtIndex:indexPath.row] title] != (id)[NSNull null])
    {
        cell.titleLabel.text = [(DataModel *)[self.datalists objectAtIndex:indexPath.row] title];
    }
    
    if ([(DataModel *)[self.datalists objectAtIndex:indexPath.row] imageUrl] !=  (id)[NSNull null]) {
        
        NSURL *url = [NSURL URLWithString:[(DataModel *)[self.datalists objectAtIndex:indexPath.row] imageUrl]];
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *image = [UIImage imageWithData:data];
                if (image) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                         cell = (DataCell *)[tableView cellForRowAtIndexPath:indexPath];
                        cell.cellImage.image = image;

                    });
                }
            }
        }];
        [task resume];
    }
    else {
        
        cell.cellImage.image = [UIImage imageNamed:@"defaultIcon"];
    }
    
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
    
    int totalHeight = 0;
    if (([(DataModel *)[self.datalists objectAtIndex:indexPath.row] descriptionTitle]) != (id)[NSNull null])
    {
        totalHeight += [self calculateHeightWith:[(DataModel *)[self.datalists objectAtIndex:indexPath.row] descriptionTitle]];
        totalHeight+=5;
    }
    if (([(DataModel *)[self.datalists objectAtIndex:indexPath.row] title]) != (id)[NSNull null])
    {
        totalHeight += [self calculateHeightWith:[(DataModel *)[self.datalists objectAtIndex:indexPath.row] title]];
        totalHeight+=5;
    }
    //set custom height whoes data is less than image height
    if(totalHeight <= 30)
    {
        return 40;
    }
    
    return totalHeight;
}

- (CGFloat)calculateHeightWith:(NSString *)textstr
{
    NSString *text = textstr;
    CGFloat width = cell.frame.size.width;
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc] initWithString:text
                                    attributes:@{NSFontAttributeName: font}];
    CGRect rect = [attributedText boundingRectWithSize:(CGSize){width, CGFLOAT_MAX}
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    CGFloat height = ceilf(size.height);
    
    return height;
}

//MARK: Notification Handlers

- (void)receiveDataObjects:(NSNotification *) notification
{
    NSMutableDictionary *dict = (NSMutableDictionary *)notification.object;
    if(dict.count > 0){
        
        _navTitle = [dict objectForKey:@"title"];
        self.datalists = [dict objectForKey:@"rows"];
        self.navigationItem.title = _navTitle;
        [self.tableView reloadData];
    }
}
@end
