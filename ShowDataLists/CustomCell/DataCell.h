//
//  DataCell.h
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataCell : UITableViewCell
{    
}
@property(strong, nonatomic)UIImageView *cellImage;
@property(strong, nonatomic)UILabel *descriptionLabel;
@property(strong, nonatomic)UILabel *titleLabel;
@end
