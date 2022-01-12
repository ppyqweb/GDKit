//
//  UIFont+GDAdd.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "UIFont+GDAdd.h"

static CGFloat kFont20 = 20;
static CGFloat kFont22 = 22;
static CGFloat kFont24 = 24;
static CGFloat kFont26 = 26;
static CGFloat kFont28 = 28;
static CGFloat kFont30 = 30;
static CGFloat kFont32 = 32;
static CGFloat kFont34 = 34;
static CGFloat kFont36 = 36;
static CGFloat kFont38 = 38;
static CGFloat kFont40 = 40;
static CGFloat kFont42 = 42;
static CGFloat kFont44 = 44;
static CGFloat kFont46 = 46;
static CGFloat kFont48 = 48;
static CGFloat kFont50 = 50;
static CGFloat kFont56 = 56;
static CGFloat kFont60 = 60;

//特殊
static CGFloat kFont76 = 76;
static CGFloat kFont120 = 120;

//先以0.5倍比例进行替换
#define PT_SCALE 0.5f

@implementation UIFont (GDAdd)


+ (UIFont *)gd_fontWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"PingFangSC-Regular" size:(size * PT_SCALE)];
}

+ (UIFont *)gd_boldFontWithSize:(CGFloat)size {
    
    return [UIFont fontWithName:@"PingFangSC-Medium" size:(size * PT_SCALE)];
}

#pragma mark - 常用字体

+ (UIFont *)gd_fontForNavigation {
    
    return [UIFont gd_fontFor36];
}

+ (UIFont *)gd_fontForTitle {
    
    return [UIFont gd_fontFor32];
}

+ (UIFont *)gd_fontForSubTitle {
    
    return [UIFont gd_fontFor28];
}

+ (UIFont *)gd_fontForContent {
    
    return [UIFont gd_fontFor28];
}



#pragma mark - 正常字体

+ (UIFont *)gd_fontFor20 {
    
    return [UIFont gd_fontWithSize:kFont20];
}

+ (UIFont *)gd_fontFor22 {
    
    return [UIFont gd_fontWithSize:kFont22];
}

+ (UIFont *)gd_fontFor24 {
    
    return [UIFont gd_fontWithSize:kFont24];
}

+ (UIFont *)gd_fontFor26 {
    
    return [UIFont gd_fontWithSize:kFont26];
}

+ (UIFont *)gd_fontFor28 {
    
    return [UIFont gd_fontWithSize:kFont28];
}

+ (UIFont *)gd_fontFor30 {
    
    return [UIFont gd_fontWithSize:kFont30];
}

+ (UIFont *)gd_fontFor32 {
    
    return [UIFont gd_fontWithSize:kFont32];
}

+ (UIFont *)gd_fontFor34 {
    
    return [UIFont gd_fontWithSize:kFont34];
}

+ (UIFont *)gd_fontFor36 {
    
    return [UIFont gd_fontWithSize:kFont36];
}

+ (UIFont *)gd_fontFor38 {
    
    return [UIFont gd_fontWithSize:kFont38];
}

+ (UIFont *)gd_fontFor40 {
    
    return [UIFont gd_fontWithSize:kFont40];
}

+ (UIFont *)gd_fontFor42 {
    
    return [UIFont gd_fontWithSize:kFont42];
}

+ (UIFont *)gd_fontFor44 {
    
    return [UIFont gd_fontWithSize:kFont44];
}

+ (UIFont *)gd_fontFor46 {
    
    return [UIFont gd_fontWithSize:kFont46];
}

+ (UIFont *)gd_fontFor48 {
    
    return [UIFont gd_fontWithSize:kFont48];
}

+ (UIFont *)gd_fontFor50 {
    
    return [UIFont gd_fontWithSize:kFont50];
}



+ (UIFont *)gd_fontFor60 {
    
    return [UIFont gd_fontWithSize:kFont60];
}

+ (UIFont *)gd_fontFor76 {
    
    return [UIFont gd_fontWithSize:kFont76];
}

+ (UIFont *)gd_fontFor120 {
    
    return [UIFont gd_fontWithSize:kFont120];
}

#pragma mark - 加粗字体

+ (UIFont *)gd_boldFontFor20 {
    
    return [UIFont gd_boldFontWithSize:kFont20];
}

+ (UIFont *)gd_boldFontFor22 {
    
    return [UIFont gd_boldFontWithSize:kFont22];
}

+ (UIFont *)gd_boldFontFor24 {
    
    return [UIFont gd_boldFontWithSize:kFont24];
}

+ (UIFont *)gd_boldFontFor26 {
    
    return [UIFont gd_boldFontWithSize:kFont26];
}

+ (UIFont *)gd_boldFontFor28 {
    
    return [UIFont gd_boldFontWithSize:kFont28];
}

+ (UIFont *)gd_boldFontFor30 {
    
    return [UIFont gd_boldFontWithSize:kFont30];
}

+ (UIFont *)gd_boldFontFor32 {
    
    return [UIFont gd_boldFontWithSize:kFont32];
}

+ (UIFont *)gd_boldFontFor34 {
    
    return [UIFont gd_boldFontWithSize:kFont34];
}

+ (UIFont *)gd_boldFontFor36 {
    
    return [UIFont gd_boldFontWithSize:kFont36];
}

+ (UIFont *)gd_boldFontFor38 {
    
    return [UIFont gd_boldFontWithSize:kFont38];
}

+ (UIFont *)gd_boldFontFor40 {
    
    return [UIFont gd_boldFontWithSize:kFont40];
}

+ (UIFont *)gd_boldFontFor42 {
    
    return [UIFont gd_boldFontWithSize:kFont42];
}

+ (UIFont *)gd_boldFontFor44 {
    
    return [UIFont gd_boldFontWithSize:kFont44];
}

+ (UIFont *)gd_boldFontFor46 {
    
    return [UIFont gd_boldFontWithSize:kFont46];
}

+ (UIFont *)gd_boldFontFor48 {
    
    return [UIFont gd_boldFontWithSize:kFont48];
}

+ (UIFont *)gd_boldFontFor50 {
    
    return [UIFont gd_boldFontWithSize:kFont50];
}

+ (UIFont *)gd_boldFontFor56 {
    return [UIFont gd_boldFontWithSize:kFont56];
}

+ (UIFont *)gd_boldFontFor60 {
    
    return [UIFont gd_boldFontWithSize:kFont60];
}

+ (UIFont *)gd_boldFontFor76 {
    
    return [UIFont gd_boldFontWithSize:kFont76];
}


@end
