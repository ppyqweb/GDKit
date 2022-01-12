//
//  UIView+GDFrame.h
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (GDFrame)

@property (nonatomic, assign) CGPoint cOrigin; //!< 位置
@property (nonatomic, assign) CGSize cSize; //!< 大小
@property (nonatomic, assign) CGFloat height; //!< 高度
@property (nonatomic, assign) CGFloat width; //!< 宽度
@property (nonatomic, assign) CGFloat top; //!< 上
@property (nonatomic, assign) CGFloat left; //!< 左
@property (nonatomic, assign) CGFloat bottom; //!< 下
@property (nonatomic, assign) CGFloat right; //!< 右

@end

NS_ASSUME_NONNULL_END
