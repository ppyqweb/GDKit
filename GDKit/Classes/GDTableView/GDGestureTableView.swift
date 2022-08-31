//
//  GDGestureTableView.swift
//  GDKit
//
//  Created by GDKit on 01/11/2022.
//  Copyright (c) 2022 GDKit. All rights reserved.
//

import UIKit

open class GDGestureTableView:  UITableView {
    
}


extension GDGestureTableView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
        // 仅仅让HomeVC的tableFooterView区域支持多个手势共存, 解决分页以上部分的"横向滑动视图(嵌套UICollectionView)"和scrollView的纵向滑动的手势冲突问题
        //        let currentPoint = gestureRecognizer.location(in: self)
        //        let segmentViewContentScrollViewHeight = self.tableFooterView?.frame.size.height ?? 0
        //        let frame = CGRect(x: 0, y: self.contentSize.height - segmentViewContentScrollViewHeight, width: UIScreen.main.bounds.size.width, height: segmentViewContentScrollViewHeight)
        //        let isContainsPoint = frame.contains(currentPoint)
        //        return isContainsPoint ? true : false
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}



open class GDGestureScrollView:  UIScrollView {
    
}


extension GDGestureScrollView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
        // 仅仅让HomeVC的tableFooterView区域支持多个手势共存, 解决分页以上部分的"横向滑动视图(嵌套UICollectionView)"和scrollView的纵向滑动的手势冲突问题
        //        let currentPoint = gestureRecognizer.location(in: self)
        //        let segmentViewContentScrollViewHeight = 0.0 //self.tableFooterView?.frame.size.height ?? 0
        //        let frame = CGRect(x: 0, y: self.contentSize.height - segmentViewContentScrollViewHeight, width: UIScreen.main.bounds.size.width, height: segmentViewContentScrollViewHeight)
        //        let isContainsPoint = frame.contains(currentPoint)
        //        return isContainsPoint ? true : false
    }
    
    open override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
