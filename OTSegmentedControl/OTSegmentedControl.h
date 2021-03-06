//
//  OTSegmentedControl.h
//  OTSegmentedControl
//
//  Created by yechunxiao on 14-12-7.
//  Copyright (c) 2014年 OoLongTea. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTSegmentControlDelegate
- (void)onSelectedButtonChanged:(NSInteger)index;
@end

@interface OTSegmentedControl : UIView

@property (nonatomic, strong) NSMutableArray *buttonArr;
@property (nonatomic, strong) UIImageView *selectedImage;

@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, strong) UIView *transView;
@property (nonatomic, assign) NSUInteger count;

@property (nonatomic, strong) UIImageView *bg;

-(void)insertSegmentWithTitle:(NSString *)title atIndex:(NSInteger)index;
-(void)updateSegmentTitle:(NSString *)title atIndex:(NSInteger)index;
-(void)setSegmentDisableAtIndex:(NSInteger)index;
-(void)setSegmentEnable;
-(void)jumpToIndex:(NSInteger)index;

-(void)reloadView;

@property(nonatomic,retain) id <OTSegmentControlDelegate> delegate ;

@end
