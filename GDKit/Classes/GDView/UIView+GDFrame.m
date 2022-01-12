//
//  UIView+GDFrame.m
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

#import "UIView+GDFrame.h"

@implementation UIView (GDFrame)

- (CGPoint)cOrigin {
    
    return self.frame.origin;
}

- (void)setCOrigin:(CGPoint)cOrigin {
    
    CGRect frame = self.frame;
    frame.origin = cOrigin;
    self.frame = frame;
}

- (CGSize)cSize {
    
    return self.frame.size;
}

- (void)setCSize:(CGSize)cSize {
    
    CGRect frame = self.frame;
    frame.size = cSize;
    self.frame = frame;
}

- (CGFloat)height {
    
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)width {
    
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)top {
    
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top {
    
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (CGFloat)left {
    
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left {
    
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)bottom {
    
    return CGRectGetMaxY(self.frame);
}

- (void)setBottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - CGRectGetHeight(self.frame);
    self.frame = frame;
}

- (CGFloat)right {
    
    return CGRectGetMaxX(self.frame);
}

- (void)setRight:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.origin.x = right - CGRectGetWidth(self.frame);
    self.frame = frame;
}

@end
