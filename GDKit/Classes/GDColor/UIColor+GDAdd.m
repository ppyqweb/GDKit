//
//  UIColor+GDAdd.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "UIColor+GDAdd.h"

//小面积使用，用于特别需要突出的重要文字、按钮和ICON
static NSString *kSpecialColor = @"d81918";
//用于重要级文字信息、内容标题信息
static NSString *kMainColor = @"4A4A4A";
//用于普通级别段落信息和文字
static NSString *kNormalColor = @"666666";
//用于模块分割底色及背景底色
static NSString *kBackgroundColor = @"F2F2F2";
//分隔线，用于列表和模块等重要分隔线CCCBCF
static NSString *kLineColor = @"eaeaea";
//黑色
static NSString *kBlackColor = @"404040";
//按钮红颜色
static NSString *kButtonRedColor = @"d91918";

@implementation UIColor (GDAdd)

#pragma mark - UI所需颜色

+ (UIColor *)gd_colorForMain
{
    return [UIColor gd_getColor:kMainColor];
}

+ (UIColor *)gd_colorForSpecial
{
    return [UIColor gd_getColor:kSpecialColor];
}

+ (UIColor *)gd_colorForNormal
{
    return [UIColor gd_getColor:kNormalColor];
}

+ (UIColor *)gd_colorForBackground
{
    return [UIColor gd_getColor:kBackgroundColor];
}

+ (UIColor *)gd_colorForLine
{
    return [UIColor gd_getColor:kLineColor];
}

+ (UIColor *)gd_colorForBlack
{
    return [UIColor gd_getColor:kBlackColor];
}

+ (UIColor *)gd_colorForButtonRed;
{
    return [UIColor gd_getColor:kButtonRedColor];
}

+ (UIColor *)gd_getColor:(NSString *)hexColor
{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:1.0f];
}

+ (UIColor *)gd_getColor:(NSString *)hexColor alpha:(CGFloat)alpha
{
    unsigned int red, green, blue;
    NSRange range;
    range.length =2;
    
    range.location =0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&red];
    range.location =2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&green];
    range.location =4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]]scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f)green:(float)(green/255.0f)blue:(float)(blue/255.0f)alpha:alpha];
}

+ (UIColor *)gd_randomColor
{
    return [UIColor colorWithRed:(arc4random()%255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1.0];
}

@end
