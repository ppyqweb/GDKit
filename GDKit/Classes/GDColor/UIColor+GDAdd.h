//
//  UIColor+GDAdd.h
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (GDAdd)

/**
 用于重要级文字信息、内容标题信息
 
 @return 颜色
 */
+ (UIColor *)gd_colorForMain;

/**
 小面积使用，用于特别需要突出的重要文字、按钮和ICON
 
 @return 颜色
 */
+ (UIColor *)gd_colorForSpecial;

/**
 用于普通级别段落信息和文字
 
 @return 颜色
 */
+ (UIColor *)gd_colorForNormal;

/**
 用于模块分割底色及背景底色

 
 @return 颜色
 */
+ (UIColor *)gd_colorForBackground;

/**
 分隔线颜色
 
 @return 颜色
 */
+ (UIColor *)gd_colorForLine;

/**
 黑色
 
 @return 颜色
 */
+ (UIColor *)gd_colorForBlack;

/**
 按钮红颜色
 
 @return 颜色
 */
+ (UIColor *)gd_colorForButtonRed;

/**
 16进制转颜色

 @param hexColor 16进制
 @return 颜色
 */
+ (UIColor *)gd_getColor:(NSString *)hexColor;

/**
 16进制转颜色
 
 @param hexColor 16进制
 @param alhpa 透明度
 @return 颜色
 */
+ (UIColor *)gd_getColor:(NSString *)hexColor alpha:(CGFloat)alpha;

/**
 随机颜色

 @return 颜色
 */
+ (UIColor *)gd_randomColor;

@end

NS_ASSUME_NONNULL_END
