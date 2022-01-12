//
//  UIFont+GDAdd.h
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (GDAdd)

+ (UIFont *)gd_fontWithSize:(CGFloat)size;

+ (UIFont *)gd_boldFontWithSize:(CGFloat)size;

#pragma mark - 常用字体

+ (UIFont *)gd_fontForNavigation;

+ (UIFont *)gd_fontForTitle;

+ (UIFont *)gd_fontForSubTitle;

+ (UIFont *)gd_fontForContent;

#pragma mark - 正常字体

+ (UIFont *)gd_fontFor20;

+ (UIFont *)gd_fontFor22;

+ (UIFont *)gd_fontFor24;

+ (UIFont *)gd_fontFor26;

+ (UIFont *)gd_fontFor28;

+ (UIFont *)gd_fontFor30;

+ (UIFont *)gd_fontFor32;

+ (UIFont *)gd_fontFor34;

+ (UIFont *)gd_fontFor36;

+ (UIFont *)gd_fontFor38;

+ (UIFont *)gd_fontFor40;

+ (UIFont *)gd_fontFor42;

+ (UIFont *)gd_fontFor44;

+ (UIFont *)gd_fontFor46;

+ (UIFont *)gd_fontFor48;

+ (UIFont *)gd_fontFor50;

+ (UIFont *)gd_fontFor60;

+ (UIFont *)gd_fontFor76;

+ (UIFont *)gd_fontFor120;

#pragma mark - 加粗字体

+ (UIFont *)gd_boldFontFor20;

+ (UIFont *)gd_boldFontFor22;

+ (UIFont *)gd_boldFontFor24;

+ (UIFont *)gd_boldFontFor26;

+ (UIFont *)gd_boldFontFor28;

+ (UIFont *)gd_boldFontFor30;

+ (UIFont *)gd_boldFontFor32;

+ (UIFont *)gd_boldFontFor34;

+ (UIFont *)gd_boldFontFor36;

+ (UIFont *)gd_boldFontFor38;

+ (UIFont *)gd_boldFontFor40;

+ (UIFont *)gd_boldFontFor42;

+ (UIFont *)gd_boldFontFor44;

+ (UIFont *)gd_boldFontFor46;

+ (UIFont *)gd_boldFontFor48;

+ (UIFont *)gd_boldFontFor50;

+ (UIFont *)gd_boldFontFor56;

+ (UIFont *)gd_boldFontFor60;

+ (UIFont *)gd_boldFontFor76;

@end

NS_ASSUME_NONNULL_END
