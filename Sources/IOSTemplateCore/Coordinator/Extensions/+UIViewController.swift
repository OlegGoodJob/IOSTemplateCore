//
//  +UIViewController.swift
//
//  Created by Oleg Ben.
//

import UIKit

/// Расширение UIViewController
extension UIViewController: PresentableType {
    /// Экран Представления
    /// - Returns: UIViewController?
    public func toPresent() -> UIViewController? {
        return self
    }
}
