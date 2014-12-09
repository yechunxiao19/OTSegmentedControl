//
//  OTSegmentedControl.m
//  OTSegmentedControl
//
//  Created by yechunxiao on 14-12-7.
//  Copyright (c) 2014年 OoLongTea. All rights reserved.
//

#import "OTSegmentedControl.h"
#define lineWidth 1
@interface OTSegmentedControl ()

@property (nonatomic, assign) CGFloat viewHeight;
@property (nonatomic, assign) CGFloat viewWidth;

@end;

@implementation OTSegmentedControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = 0;
        [self setBackgroundColor:[UIColor whiteColor]];
        self.selectedImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"segmentCtrlBg_S"] stretchableImageWithLeftCapWidth:9 topCapHeight:0]];
        
        self.buttonArr = [[NSMutableArray alloc] init];
        self.viewWidth = self.frame.size.width;
        self.viewHeight = self.frame.size.height;
        
        self.bg = [[UIImageView alloc] init];
        self.bg.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight);
        [self addSubview:self.bg];
        
        self.transView = [[UIView alloc] init];
        self.transView.backgroundColor = [UIColor clearColor];
        [self.transView addSubview:self.selectedImage];
        [self addSubview:self.transView];
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    
}

-(void)reloadView{
    self.viewWidth = self.frame.size.width;
    self.viewHeight = self.frame.size.height;
    self.bg.frame = CGRectMake(0, 0, self.viewWidth, self.viewHeight);
    [self updateButtonsFrameForOren];
}

-(void)insertSegmentWithTitle:(NSString *)title atIndex:(NSInteger)index{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:nil forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:index];
    [self.buttonArr addObject:button];
    [self addSubview:button];
    [self updateButtonsFrame];
}

-(void)updateSegmentTitle:(NSString *)title atIndex:(NSInteger)index{
    if (index < self.count) {
        UIButton *btn = [self.buttonArr objectAtIndex:index];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateSelected];
    }
}

-(void)updateButtonsFrame{
    self.count = self.buttonArr.count;
    CGFloat buttonWidth = self.viewWidth/self.count;
    CGFloat buttonOrignX = 0;
    
    self.transView.frame = CGRectMake(0, 0, self.viewWidth / self.count, self.frame.size.height);
    self.selectedImage.frame = self.transView.frame;
    for (int i = 0; i < self.count; i++) {
        UIButton *button = [self.buttonArr objectAtIndex:i];
        button.frame = CGRectMake(buttonOrignX, 0, self.viewWidth / self.count, self.viewHeight);
        buttonOrignX += buttonWidth;
        if (i == 0) {
            [button setSelected:YES];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.selectedButton = button;
        }
    }
}

-(void)updateButtonsFrameForOren{
    self.selectedSegmentIndex = -1;
    self.count = self.buttonArr.count;
    CGFloat buttonWidth = self.viewWidth/self.count;
    CGFloat buttonOrignX = 0;
    self.transView.frame = CGRectMake(0, self.frame.size.height - 3, self.viewWidth / self.count, 3);
    for (int i = 0; i < self.count; i++) {
        UIButton *button = [self.buttonArr objectAtIndex:i];
        button.frame = CGRectMake(buttonOrignX, 0, self.viewWidth / self.count, self.viewHeight);
        buttonOrignX += buttonWidth;
    }
}

-(void)changeSelectedButton:(UIButton *)sender{
    if (self.selectedButton != nil) {
        [self.selectedButton setSelected:NO];
        [self.selectedButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    self.selectedButton = sender;
    [sender setSelected:YES];
    [self.selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)buttonSelected:(UIButton *)sender{
    self.selectedSegmentIndex = sender.tag;
    [self changeSelectedButton:sender];
    [UIView animateWithDuration:0.2 animations:^{
        [self.transView setFrame:CGRectMake(sender.tag * self.viewWidth / self.count, self.transView.frame.origin.y,self.transView.frame.size.width, self.transView.frame.size.height)];
    }];
    
    
    [self.delegate onSelectedButtonChanged:sender.tag];
}

-(void)setSegmentDisableAtIndex:(NSInteger)index{
    if (index < self.count) {
        UIButton *btn = [self.buttonArr objectAtIndex:index];
        [btn setEnabled:NO];
    }
}

-(void)setSegmentEnable{
    for (UIButton *btn in self.buttonArr) {
        [btn setEnabled:YES];
    }
}

-(void)jumpToIndex:(NSInteger)index{
    if (index != self.selectedSegmentIndex) {
        UIButton *btn = [self.buttonArr objectAtIndex:index];
        self.selectedSegmentIndex = btn.tag;
        [self changeSelectedButton:btn];
        [UIView animateWithDuration:0.2 animations:^{
            [self.transView setFrame:CGRectMake(btn.tag * self.viewWidth / self.count, self.transView.frame.origin.y,self.transView.frame.size.width, self.transView.frame.size.height)];
        }];
        [self.delegate onSelectedButtonChanged:index];
    }
}

@end
