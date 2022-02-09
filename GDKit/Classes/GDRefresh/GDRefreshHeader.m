//
//  GDRefreshHeader.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "GDRefreshHeader.h"

#import "GDRefreshConfig.h"

static NSString *kRefreshingText = @"正在刷新中...";
static NSString *kRefreshIdleText = @"下拉刷新";
static NSString *kRefreshIdleSuccessText = @"刷新成功";
static NSString *kRefreshPullingText = @"松开立即刷新";

@interface GDRefreshHeader ()

@property (nonatomic, assign) BOOL isChangeText;   //!< 是否变化文本
@property (nonatomic, strong) UILabel *titleLabel; //!< 标题
@property (nonatomic, strong) UIImageView *logoImageView; //!< logo

@property (nonatomic, strong) NSArray *firstArray; //!< 前部分
@property (nonatomic, strong) NSArray *lastArray; //!< 后部分


@end

@implementation GDRefreshHeader


#pragma mark - 1、生命周期函数 life cycle
// 重写prepare
- (void)prepare {
    
    [super prepare];
    
    self.mj_h = 50;
    self.isChangeText = false;

    //默认配置
    [self config];

    [self addSubview:self.titleLabel];
    [self addSubview:self.logoImageView];
    
    [self setImageAnimation];
    
    __weak GDRefreshHeader *weakSelf = self;
    __strong GDRefreshHeader *strongSelf = weakSelf;
    self.endRefreshingCompletionBlock = ^{
        
        strongSelf.titleLabel.text = kRefreshIdleText;
        strongSelf.logoImageView.image = [strongSelf.firstArray firstObject];
    };
    

    //添加约束
    [self p_addConstraintLogoImageView];
    [self p_addConstraintsTitleLabel];
}

- (void)config {
    
    self.firstArray = [GDRefreshConfig sharedInstance].frontArray;
    self.lastArray = [GDRefreshConfig sharedInstance].laterArray;
}

- (void)p_addConstraintLogoImageView {
    
    self.logoImageView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-15.f];
    [self addConstraint:c1];
    
    //水平居中
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self addConstraint:c2];
    
    //宽 20.f
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:20.f];
    [self.logoImageView addConstraint:c3];
    
    //高 等于宽
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:self.logoImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.logoImageView attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.f];
    [self.logoImageView addConstraint:c4];
}

- (void)p_addConstraintsTitleLabel {
    
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint *c1 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.logoImageView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.f];
    [self addConstraint:c1];
    
    //水平居中
    NSLayoutConstraint *c2 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.f];
    [self addConstraint:c2];
    
    //宽 100.f
    NSLayoutConstraint *c3 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:100.f];
    [self.titleLabel addConstraint:c3];
    
    //高 15
    NSLayoutConstraint *c4 = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:15.f];
    [self.titleLabel addConstraint:c4];
}

// 重写placeSubviews
- (void)placeSubviews {
    
    [super placeSubviews];
}

#pragma mark - 2、系统代理 system delegate

#pragma mark - 3、自定义代理 custom delegete

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState;
    
    switch (state) {
            
        case MJRefreshStateIdle:
        {
            [self.logoImageView stopAnimating];
            
            if (self.isChangeText) {
                
                self.titleLabel.text = kRefreshIdleSuccessText;
                self.logoImageView.image = [self.lastArray lastObject];
                
                self.isChangeText = NO;
            }
            else {
                
                self.titleLabel.text = kRefreshIdleText;
                self.logoImageView.image = [self.firstArray firstObject];
            }
            
        }
            break;
        case MJRefreshStatePulling:
        {
            
            [self.logoImageView stopAnimating];
            
            self.titleLabel.text = kRefreshPullingText;
            self.logoImageView.image = [self.firstArray lastObject];
        }
            break;
        case MJRefreshStateRefreshing:
        {
            
            self.titleLabel.text = kRefreshingText;
            self.isChangeText = YES;
            if (!self.logoImageView.isAnimating) {
                
                [self.logoImageView startAnimating];
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent {
    
    [super setPullingPercent:pullingPercent];
    
    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44.f;
    NSInteger page = (NSInteger)((pullingPercent * topHeight) / (topHeight / [self.firstArray count]));
    
    if (page == 0) {
        
        page = 1;
    }
    
    if (page <= [self.firstArray count]) {
        
        self.logoImageView.image = self.firstArray[page - 1];
    }
}

#pragma mark - 4、相关响应事件 event response

#pragma mark - 5、自定义函数 private methods

//读取NSBundle中图片
- (UIImage *)jzyi_imageNamed:(NSString *)name{
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    return [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
//    return [UIImage imageNamed:name];
}

//读取NSBundle中图片
- (UIImage *)jzyi_imageNamed:(NSString *)name bundleName:(NSString *)bundleName class:(Class)class{
    
    NSBundle *bundle = [NSBundle bundleForClass:class];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *newBundle = [NSBundle bundleWithURL:url];
    
    UIImage *image = [UIImage imageNamed:name inBundle:newBundle compatibleWithTraitCollection:nil];
    
    return image;
}

//设置图片动画
- (void)setImageAnimation{
    
//    NSMutableArray *mArray = [NSMutableArray array];
//    for (NSInteger i = 40; i < 70; i++) {
//
//        [mArray addObject:[self jzyi_imageNamed:[NSString stringWithFormat:@"%@%02ld",kRefreshingImageName,(long)i]]];
//    }
    self.logoImageView.animationImages = self.lastArray;
    self.logoImageView.animationDuration = 1.5;
    self.logoImageView.animationRepeatCount = 0;
}

#pragma mark - 6、初始化（统一用懒加载） getters or setters

- (UIImageView *)logoImageView {
    
    if (!_logoImageView) {
        
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _logoImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:10.f];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
