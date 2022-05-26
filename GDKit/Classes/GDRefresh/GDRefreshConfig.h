//
//  GDRefreshConfig.h
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 头部类型
typedef NS_ENUM(NSUInteger, GDRefreshHeaderType) {
    
    GDRefreshHeaderTypeNormal,
    GDRefreshHeaderTypeGif,
    GDRefreshHeaderTypeCustom
};

// 尾部类型
typedef NS_ENUM(NSUInteger, GDRefreshFooterType) {
    
    GDRefreshFooterTypeBack,
    GDRefreshFooterTypeAuto
};

@interface GDRefreshConfig : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readwrite, strong) NSArray <UIImage *> *frontArray; //!< 前部分
@property (nonatomic, readwrite, strong) NSArray <UIImage *> *laterArray; //!< 后部分

@property (nonatomic, readwrite, assign) GDRefreshHeaderType headerType ; //!< 头部类型
@property (nonatomic, readwrite, assign) GDRefreshHeaderType footerType ; //!< 尾部类型

@end

NS_ASSUME_NONNULL_END
