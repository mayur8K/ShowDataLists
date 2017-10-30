//
//  JsonParser.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "JsonParser.h"
#import "DataModel.h"

@implementation JsonParser

-(NSMutableDictionary *)parseJsonDataWithData:(NSData *)jsonData andError:(NSError *)error
{
    
    NSString *encodedString = [[NSString alloc] initWithData:jsonData encoding:NSISOLatin1StringEncoding];
    NSData *decodedData = [encodedString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dataList = [NSJSONSerialization JSONObjectWithData: decodedData
                                                             options: NSJSONReadingMutableContainers
                                                               error: &error];
    if (error)
    {
        NSLog(@"Error: %@",error);
    }
    
    NSString *title = [dataList valueForKey:@"title"];
    NSMutableArray *rows = [dataList valueForKey:@"rows"];
    NSMutableArray *dataObjects = [NSMutableArray array];
    NSMutableDictionary *dataItems = [NSMutableDictionary dictionary];
   
    for(int i =0; i< rows.count; i++)
    {
        DataModel *model = [[DataModel alloc] init];
        model.imageUrl = [[rows objectAtIndex:i] valueForKey:@"imageHref"];
        model.title = [[rows objectAtIndex:i] valueForKey:@"title"];
        model.descriptionTitle = [[rows objectAtIndex:i] valueForKey:@"description"];
        [dataObjects addObject:model];
    }
    
    if ([dataObjects count] > 0)
    {
        [dataItems setObject:title forKey:@"title"];
        [dataItems setObject:dataObjects forKey:@"rows"];
        return dataItems;
    }
    
    return nil;
}
@end
