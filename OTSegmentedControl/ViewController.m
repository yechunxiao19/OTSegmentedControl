//
//  ViewController.m
//  OTSegmentedControl
//
//  Created by yechunxiao on 14-12-7.
//  Copyright (c) 2014年 OoLongTea. All rights reserved.
//

#import "ViewController.h"
#import "OTSegmentedControl.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    OTSegmentedControl *sc = [[OTSegmentedControl alloc] initWithFrame:CGRectMake(0, 50, 320, 50)];
    [sc insertSegmentWithTitle:@"test1" atIndex:0];
    [sc insertSegmentWithTitle:@"test2" atIndex:1];
    [sc insertSegmentWithTitle:@"test3" atIndex:2];
    [sc insertSegmentWithTitle:@"test4" atIndex:3];
    [self.view addSubview:sc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
