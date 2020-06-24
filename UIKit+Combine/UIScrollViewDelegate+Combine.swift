//
//  UIScrollView+Combine.swift
//  PersonalStats
//
//  Created by Pierre Perrin on 24/06/2020.
//  Copyright © 2020 PP. All rights reserved.
//

import Foundation
import UIKit
import Combine

private class UIScrollViewDelegateProxy: DelegateProxy, UIScrollViewDelegate, DelegateProxyType {
    func setDelegate(to object: UIScrollView) {
        object.delegate = self
    }
}

extension UIScrollView {

    private var delegateProxy: UIScrollViewDelegateProxy {
        return .createDelegateProxy(for: self)
    }

    /// Combine wrapper for `scrollViewDidScroll(_ scrollView:)`
    public var scrollViewDidScrollPublisher: AnyPublisher<UIScrollView, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[0] as! Self }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidZoom(_ scrollView:)`
    public var scrollViewDidZoomPublisher: AnyPublisher<UIScrollView, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidZoom(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[0] as! Self }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillBeginDragging(_ scrollView:)`
    public var scrollViewWillBeginDraggingPublisher: AnyPublisher<UIScrollView, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[0] as! Self }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)`
    public var scrollViewWillEndDraggingPublisher: AnyPublisher<CGPoint, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillEndDragging(_:withVelocity:targetContentOffset:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! CGPoint }
            .eraseToAnyPublisher()
    }

}
