//
//  GDRefreshConfig.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "GDRefreshConfig.h"

@implementation GDRefreshConfig

+ (instancetype)sharedInstance {
    
    static GDRefreshConfig *config = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        config = [[[self class] alloc] init];
    });
    return config;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _headerType = GDRefreshHeaderTypeNormal;
        _footerType = GDRefreshFooterTypeBack;
    }
    return self;
}

@end
