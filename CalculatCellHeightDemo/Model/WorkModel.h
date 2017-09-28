//
//  WorkModel.h
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WorkModel : NSObject

@property (nonatomic, strong) NSString *imagename;

@property (nonatomic, strong) NSString *namestring;

@property (nonatomic, strong) NSString *descrip;


//用来缓存cell的高度
@property (nonatomic, assign) CGFloat cellHeight;

@end
