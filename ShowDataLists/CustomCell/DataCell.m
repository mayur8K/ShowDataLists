//
//  DataCell.m
//  ShowDataLists
//
//  Created by iOS Dev on 10/30/17.
//  Copyright © 2017 iOS Dev. All rights reserved.
//

#import "DataCell.h"

@interface DataCell(){
    
    
}
@end

@implementation DataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

// MARK: Private Methods
- (void)setupViews
{
    _cellImage = [[UIImageView alloc] init];
    _cellImage.translatesAutoresizingMaskIntoConstraints = NO;
    _cellImage.backgroundColor = [UIColor greenColor];
    [self addSubview:_cellImage];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont fontWithName:@"Arial" size:15.0f];
    [self addSubview:_titleLabel];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = false;
    _descriptionLabel.textColor = [UIColor blackColor];
    _descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
    [self addSubview:_descriptionLabel];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_cellImage, _titleLabel);
    
    NSArray *horizontalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_cellImage(50)]|" options:0 metrics:nil views:views];
    
    NSArray *verticalConstraints =[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[_cellImage(50)]-(5)-|" options:0 metrics:nil views:views];
    
    [self addConstraints:horizontalConstraints];
    [self addConstraints:verticalConstraints];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_cellImage attribute:NSLayoutAttributeTop multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_cellImage attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBaseline multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_cellImage attribute:NSLayoutAttributeRight multiplier:1.0 constant:5]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_descriptionLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:5]];
    
}

@end
