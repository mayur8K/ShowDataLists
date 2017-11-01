//
//  DataManager.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "DataManager.h"
#import "CommunicationService.h"

#define urlstring @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

@interface DataManager()<dataManagerDelegate>

@property(strong, nonatomic)NSMutableDictionary *dataItems;
@property(strong, nonatomic)NSString *title;
@property(strong, nonatomic)CommunicationService *serviceObj;
@end

@implementation DataManager

//Get data from server. exposed API To UI
- (void)getServerData
{
    _serviceObj = [[CommunicationService alloc] init];
    _serviceObj.delegate = self;
    [_serviceObj loadServerDataWithUrl:urlstring];
}

//MARK:Notification handler
//Send data to UI through notification.. do dependancy on UI.. not strongly binded.
- (void)sendDataItems:(NSMutableDictionary *)dictionary
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOADLIST_NOTIFICATION" object:dictionary];
    });
}

@end
