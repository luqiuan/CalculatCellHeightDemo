//
//  CustomCell.m
//  CalculatCellHeightDemo
//
//  Created by luqiuan on 2017/9/28.
//  Copyright © 2017年 luqiuan. All rights reserved.
//

#import "CustomCell.h"
#import "Defines.h"
#import "UIView+Frame.h"
#import "Utils.h"

static CGFloat CustomCellHeight;//定义一个静态全局变量存取cell的高度

@interface CustomCell ()

@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *descriptionLabel;

@end

@implementation CustomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(spaceOfHorizontal, spaceOfVertical, SCREEN_WIDTH - spaceOfHorizontal * 2, 90 - 30)];
    [self.contentView addSubview:self.backView];
    self.backView.layer.cornerRadius = 4;
    self.backView.backgroundColor = [UIColor whiteColor];
    //添加四个边阴影
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    self.backView.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    self.backView.layer.shadowOpacity = 0.3;//不透明度
    self.backView.layer.shadowRadius = 6.0;////阴影半径，默认3
    
    self.headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(spaceOfContent, spaceOfContent, 30, 30)];
    [self.backView addSubview:self.headImageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 5, spaceOfHorizontal, self.backView.width - (self.headImageView.right + 5 - spaceOfContent), 20)];
    self.nameLabel.font = [UIFont systemFontOfSize:16];
    self.nameLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1];
    [self.nameLabel setCenterY:self.headImageView.centerY];
    [self.backView addSubview:self.nameLabel];
    
    self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(spaceOfContent, self.headImageView.bottom + 10, self.backView.width - spaceOfHorizontal * 2, 20)];
    self.descriptionLabel.font = [UIFont systemFontOfSize:14];
    self.descriptionLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
    self.descriptionLabel.numberOfLines = 0;
    [self.backView addSubview:self.descriptionLabel];
}

- (void)configData:(WorkModel *)model{
    self.headImageView.image = [UIImage imageNamed:model.imagename];
    self.nameLabel.text = model.namestring;
    self.descriptionLabel.text = model.descrip;
    CGSize textSize = [Utils countLabelWithText:model.descrip Font:14 Width:self.descriptionLabel.width];
    [self.descriptionLabel setHeight:textSize.height];
    [self.backView setHeight:self.descriptionLabel.bottom+spaceOfContent];
    //使用model来存储高度，使用这种方法时，一定要保证对传过来的model一直处于引用状态，这样对model.cellHeight赋值才有意义。
    model.cellHeight = self.backView.bottom + spaceOfVertical;
    //使用静态变量来存储高度，使用这种方法需添加一个对外接口来获取这个静态变量的值，需要注意的是，静态变量在所有创建的cell中只存在一份，也就是说只能在调用configData函数之后，再调用cellHeight函数获取高度才能保证获取到的高度是正确的。在iOS8.0以后刷新某行cell时系统能保证在调用heightForRowAtIndexPath函数之前先调用cellForRowAtIndexPath函数，这样就能确保获取到的cell是正确的。
    CustomCellHeight = self.backView.bottom + spaceOfVertical;
}

+ (CGFloat)cellHeight{
    return CustomCellHeight;
}

@end
