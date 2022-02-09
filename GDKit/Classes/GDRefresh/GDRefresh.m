//
//  GDRefresh.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "GDRefresh.h"

#import "GDRefreshHeader.h"

@implementation GDRefresh
{
    UIScrollView *_tempScrollView;
}

- (instancetype)initWithMainView:(UIView *)mainView {
    
    if (self = [super init]) {
        
        _tempScrollView = (UIScrollView *)mainView;
    }
    return self;
}

- (void)headerRefreshFinish:(GDRefreshHeaderBlock)block {
    //GDRefreshHeader
    _tempScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        block();
    }];
}

- (void)endHeaderRefresh {
    
    [_tempScrollView.mj_header endRefreshing];
}

- (void)immediatelyHeaderRefresh {
    
    [_tempScrollView.mj_header beginRefreshing];
}

- (void)footerRefreshFinish:(GDRefreshFooterBlock)block {
    
    _tempScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        block();
    }];
}

- (void)endFooterRefresh {
    
    [_tempScrollView.mj_footer endRefreshing];
}

- (void)endFooterNoDataRefresh {
    
    [_tempScrollView.mj_footer endRefreshingWithNoMoreData];
}

- (void)footerRefreshForNoDataTitle:(NSString *)title
                         withFinish:(GDRefreshFooterBlock)block {
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        if (block) {
            
            block();
        }
    }];
    [footer setTitle:title forState:MJRefreshStateNoMoreData];
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    footer.stateLabel.textColor = [UIColor colorWithHue:152.0/255 saturation:152.0/255 brightness:152.0/255 alpha:1.f];
    _tempScrollView.mj_footer = footer;
}

@end
