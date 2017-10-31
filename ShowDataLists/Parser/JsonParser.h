//
//  JsonParser.h
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonParser : NSObject

-(NSMutableDictionary *)parseJsonDataWithData:(NSData *)jsonData andError:(NSError *)error;
@end
