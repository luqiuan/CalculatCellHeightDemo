//
//  Utils.h
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Utils : NSObject
//计算label
+ (CGSize) countLabelWithText:(NSString *)text Font:(CGFloat)font Width:(CGFloat)width;

//获取颜色
+ (UIColor *)getColor:(NSString *)hexColor;
@end
