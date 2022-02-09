//
//  GDRefresh.h
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^GDRefreshHeaderBlock)(void);
typedef void(^GDRefreshFooterBlock)(void);

@interface GDRefresh : NSObject

- (instancetype)initWithMainView:(UIView *)mainView;

/**
 *  下拉刷新
 *
 *  @param block 回调
 */
- (void)headerRefreshFinish:(GDRefreshHeaderBlock)block;

/**
 *  结束下拉刷新
 */
- (void)endHeaderRefresh;

/**
 *  立即下拉刷新
 */
- (void)immediatelyHeaderRefresh;

/**
 *  上拉刷新
 *
 *  @param block 回调
 */
- (void)footerRefreshFinish:(GDRefreshFooterBlock)block;

/**
 *  结束上拉刷新
 */
- (void)endFooterRefresh;

/**
 *  进入无数据时提示
 */
- (void)endFooterNoDataRefresh;

/**
 *  无数据时特殊提示上拉刷新
 *
 *  @param title 无数据时特殊提示文字
 *  @param block 回调
 */
- (void)footerRefreshForNoDataTitle:(NSString *)title
                         withFinish:(GDRefreshFooterBlock)block;

@end

NS_ASSUME_NONNULL_END
