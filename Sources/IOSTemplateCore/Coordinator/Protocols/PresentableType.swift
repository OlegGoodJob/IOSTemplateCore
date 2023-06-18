//
//  PresentableType.swift
//
//  Created by Oleg Ben.
//

import UIKit

/// Протокол Представления
public protocol PresentableType {
    /// Получить экран Представления
    /// - Returns: UIViewController?
    func toPresent() -> UIViewController?
}
