//
//  DZStarView.m
//  JSCoreDemo
//
//  Created by Jemmy on 2018/10/18.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

#import "DZStarView.h"

static  NSString * const redImageName = @"redstar.png";
static  NSString * const grayImageName = @"graystar.png";
static const CGFloat space = 10;
@implementation DZStarView{
    NSMutableArray<UIImageView *> *_imageArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/

- (void)awakeFromNib{
    [super awakeFromNib];
  
}

-(instancetype)initWithMaxCount:(NSInteger)count value:(NSInteger)value canEvlaue:(BOOL)evalue frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.maxCount = count;
        self.value = value;
        self.canEvlaue = evalue;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [tap addTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    CGPoint p = [gesture locationInView:self];
    CGFloat margin = self.bounds.size.width / self.maxCount;
    int index;
    index = p.x / margin;
    self.value = index + 1;
    [self changeImage];
    if ([self.delegate respondsToSelector:@selector(starView:didClick:)]) {
        [self.delegate starView:self didClick:self.value];
    }
}
-(void)setCanEvlaue:(BOOL)canEvlaue{
    _canEvlaue = canEvlaue;
    self.userInteractionEnabled = canEvlaue;
}

-(void)setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    
    [self addStar];
}

-(void)setValue:(NSInteger)value{
    _value = value;
    [self changeImage];
    
}
-(void)changeImage{
    __weak typeof(self) wself = self;
    [_imageArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.image = idx<wself.value ? [UIImage imageNamed:redImageName] : [UIImage  imageNamed:grayImageName];
    }];
}


 - (void)drawRect:(CGRect)rect {
     ///绘制五角星
    // Drawing code
//     CGContextRef context = UIGraphicsGetCurrentContext();
//     CGContextSetLineWidth(context, 1);
//     CGFloat radius = (self.bounds.size.width -20) / 10;
//     NSMutableArray<NSString *> *pointArray = [NSMutableArray new];
//     UIBezierPath *path = [UIBezierPath new];
//     path.lineWidth = 1;
//     CGFloat margin = self.bounds.size.width / 6.0;
//     CGFloat avaAngel = M_PI * 2 / 5;
//
//     for (int j = 1; j<6; j++) {
//         [path moveToPoint:CGPointMake(margin * j + 5 , self.center.y)];
//         for (int i = 0; i <5; i ++) {
//             CGFloat x = margin *j - cosf(M_PI_2 - avaAngel * i) * radius ;
//             CGFloat y = self.bounds.size.height/2 - sinf(M_PI_2 - avaAngel * i) * radius;
//             CGPoint po = CGPointMake(x, y);
//             [pointArray addObject:NSStringFromCGPoint(po)];
//         }
//
//         [path addLineToPoint: CGPointFromString(pointArray[0])];
//         [path addLineToPoint: CGPointFromString(pointArray[2])];
//         [path addLineToPoint: CGPointFromString(pointArray[4])];
//         [path addLineToPoint: CGPointFromString(pointArray[1])];
//         [path addLineToPoint: CGPointFromString(pointArray[3])];
//         [path addLineToPoint: CGPointFromString(pointArray[0])];
//         CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//         CGContextAddPath(context, path.CGPath);
//         CGContextDrawPath(context, kCGPathFill);
//         CGContextStrokePath(context);
//         [pointArray removeAllObjects];
//     }
//
 }

-(void)addStar{
    if (_imageArray) {
        [_imageArray enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
    }
    CGFloat point = self.bounds.size.width / (CGFloat)(_maxCount + 1);
    CGFloat imageW = (self.bounds.size.width - space * (_maxCount + 1)) / (CGFloat)_maxCount;
    _imageArray = [NSMutableArray new];
    for (int i = 1; i<=_maxCount; i++) {
        UIImageView *starImage = [UIImageView new];
        starImage.image = [UIImage  imageNamed:grayImageName];
        starImage.center = CGPointMake(point * i, self.bounds.size.height/2.0);
        starImage.bounds = CGRectMake(0, 0, imageW, imageW);
        [_imageArray addObject:starImage];
        [self addSubview:starImage];
    }
    
}

@end
