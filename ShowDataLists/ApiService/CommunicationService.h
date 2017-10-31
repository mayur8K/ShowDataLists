//
//  CommunicationService.h
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol dataManagerDelegate<NSObject>
- (void)sendDataItems:(NSMutableDictionary *)dictionary;
@end

@interface CommunicationService : NSObject

@property(weak, nonatomic)id<dataManagerDelegate> delegate;
- (void)loadServerDataWithUrl:(NSString *)urlString;
@end
