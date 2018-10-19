//
//  ViewController.m
//  DZStarViewDemo
//
//  Created by Jemmy on 2018/10/19.
//  Copyright © 2018年 Jemmy. All rights reserved.
//

#import "ViewController.h"
#import "DZStarView/DZStarView.h"
@interface ViewController ()<DZStarViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    DZStarView *starView = [[DZStarView alloc] initWithMaxCount:5 value:4 canEvlaue:YES frame:CGRectMake(70, 100, 200, 100)];
    starView.delegate = self;
    [self.view addSubview:starView];
}

-(void)starView:(DZStarView *)starView didClick:(NSInteger)index{
    NSLog(@"等级 == %ld",index);
}
@end
