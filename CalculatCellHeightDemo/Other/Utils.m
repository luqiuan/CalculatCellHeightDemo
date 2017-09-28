//
//  Utils.m
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import "Utils.h"
#import <Foundation/Foundation.h>
@implementation Utils

//计算label
+ (CGSize) countLabelWithText:(NSString *)text Font:(CGFloat)font Width:(CGFloat)width
{
    
    CGSize titleSize;
    titleSize = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return titleSize;
}

+ (UIColor *)getColor:(NSString *)hexColor
{
    if (hexColor.length == 6)
    {
        unsigned int red, green, blue;
        NSRange range;
        range.length = 2;
        range.location = 0;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
        range.location = 2;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
        range.location = 4;
        [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
        
        return [UIColor colorWithRed:(float)(red / 255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
    }
    else
    {
        return nil;
    }
}

@end
