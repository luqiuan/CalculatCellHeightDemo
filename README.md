# CalculatCellHeightDemo
动态计算tableViewCell高度
布局TableViewCell时总会遇到需要动态计算和设置cell的高度，比如文本长度不一、同类型的cell需要隐藏和显示某些控件、不同类型的cell等都会导致cell的高度不一致。不同高度的cell需要我们提前计算和保存高度，保证每次刷新cell时都能得到正确的高度。对于这个问题，可以看看下面两种方案。
###demo效果

![截图](http://upload-images.jianshu.io/upload_images/2269450-a3472d1d0b26a571.gif?imageMogr2/auto-orient/strip)

# 方案一  将cell的高度保存在对应的model中
使用这种方案，我们可以在model中创建一个保存高度属性，像下面这样
```
@interface WorkModel : NSObject
@property (nonatomic, strong) NSString *imagename;
@property (nonatomic, strong) NSString *namestring;
@property (nonatomic, strong) NSString *descrip;
//用来缓存cell的高度
@property (nonatomic, assign) CGFloat cellHeight;
@end
```
在`tableView:cellForRowAtIndexPath`函数中是这样写的
```
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell"];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    [cell configData:self.dataSources[indexPath.row]];
    return cell;
}
```
然后`configData:`函数是这样的
```
- (void)configData:(WorkModel *)model{
    self.headImageView.image = [UIImage imageNamed:model.imagename];
    self.nameLabel.text = model.namestring;
    self.descriptionLabel.text = model.descrip;
    CGSize textSize = [Utils countLabelWithText:model.descrip Font:14 Width:self.descriptionLabel.width];
    [self.descriptionLabel setHeight:textSize.height];
    [self.backView setHeight:self.descriptionLabel.bottom+spaceOfContent];
    //使用model来存储高度，使用这种方法时，一定要保证对传过来的model一直处于引用状态，这样对model.cellHeight赋值才有意义。
    model.cellHeight = self.backView.bottom + spaceOfVertical;
}
```
在`configData:`函数中对cell进行数据绑定，通过`countLabelWithText:`函数计算Label的实际高度后，再重新布局整个cell的高度，之后将高度保存到model中。需要注意的是，一定保证model是对原始值的引用，否则这样保存高度将毫无意义。
接下来是这样获取高度的
```
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    WorkModel *model = self.dataSources[indexPath.row];
    return model.cellHeight;
}
```
# 其实这种方案还是很方便的，或者说动态计算高度本来就简单[捂脸],下面这种方案看起来出问题的几率大一些，但我还是忍不住要写出来，来打我啊~~~尼玛，用markdown编辑还是挺有味的,咦...字怎么会突然变小~
###方案二  将cell的高度保存在静态变量中
有了上面这种方案，突然发现第二种是多余的，如果你有时间不妨看看。
首先cell中有这样一个静态变量：
`static CGFloat CustomCellHeight;//定义一个静态全局变量存取cell的高度`
然后它的值是在这里设置的
```
- (void)configData:(WorkModel *)model{
    self.headImageView.image = [UIImage imageNamed:model.imagename];
    self.nameLabel.text = model.namestring;
    self.descriptionLabel.text = model.descrip;
    CGSize textSize = [Utils countLabelWithText:model.descrip Font:14 Width:self.descriptionLabel.width];
    [self.descriptionLabel setHeight:textSize.height];
    [self.backView setHeight:self.descriptionLabel.bottom+spaceOfContent];
    //使用静态变量来存储高度，使用这种方法需添加一个对外接口来获取这个静态变量的值，需要注意的是，静态变量在所有创建的cell中只存在一份，也就是说只能在调用configData函数之后，
再调用cellHeight函数获取高度才能保证获取到的高度是正确的。在iOS8.0以后刷新某行cell时系统能保证在调用heightForRowAtIndexPath函数之前先调用cellForRowAtIndexPath函数，这样就能确保获取到的cell是正确的。
    CustomCellHeight = self.backView.bottom + spaceOfVertical;
}
```
注意使用这种方案还有一些问题，在注释中稍微标注了一下，下面还会详细讲。
然后cell中还有这样一个函数用来供外部类获取这个高度：
```
+ (CGFloat)cellHeight{
    return CustomCellHeight;
}
```
然后高度是这样获取的
```
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CustomCell cellHeight];
}
```
这种方案还存在一些潜在的问题，因为静态变量始终只有一份，而每个cell的高度可能都不一样，所以每次获取高度时，都得保证是调用了`tableView:cellForRowAtIndexPath`函数之后获取的，这样才能确保高度一一对应。所以还是建议使用第一种方案。
#完
