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
{
    CommunicationService *serviceObj;
}
@property(strong, nonatomic)NSMutableDictionary *dataItems;
@property(strong, nonatomic)NSString *title;
@end

@implementation DataManager

- (void)getServerData
{
    serviceObj = [[CommunicationService alloc] init];
    serviceObj.delegate = self;
    [serviceObj loadServerDataWithUrl:urlstring];
}

- (void)sendDataItems:(NSMutableDictionary *)dictionary
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LOADLIST_NOTIFICATION" object:dictionary];
    });
    
}

@end
