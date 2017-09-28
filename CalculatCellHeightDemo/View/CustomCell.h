//
//  CustomCell.h
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkModel.h"

@interface CustomCell : UITableViewCell
- (void)configData:(WorkModel *)model;

+ (CGFloat)cellHeight;
@end
