//
//  CommunicationService.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "CommunicationService.h"
#import "JsonParser.h"

@interface CommunicationService()

@end

@implementation CommunicationService

- (void)loadServerDataWithUrl:(NSString *)urlString
{
    NSURL *serverURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:serverURL];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          JsonParser *parser = [[JsonParser alloc] init];
          NSMutableDictionary *dataItems = [parser parseJsonDataWithData:data andError:error];
          if (dataItems.count > 0)
          {
              [self.delegate sendDataItems:dataItems];
          }
      }];
    [dataTask resume];
}

@end
