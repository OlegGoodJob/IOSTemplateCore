//
//  CoordinatorType.swift
//
//  Created by Oleg Ben.
//

import Foundation

/// Протокол координатора
public protocol CoordinatorType: AnyObject {
    /// Установка зависимости на роутер
    func set(_ router: RouterType)
    /// Старт
    func start()
}
