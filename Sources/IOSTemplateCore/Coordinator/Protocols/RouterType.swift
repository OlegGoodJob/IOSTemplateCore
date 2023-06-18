//
//  RouterType.swift
//
//  Created by Oleg Ben.
//

import Foundation

/// Протокол роутера навигации
public protocol RouterType: PresentableType {
    /// Показать экран через present
    func present(_ module: PresentableType?)
    /// Показать экран через present с установкой анимации
    func present(_ module: PresentableType?, animated: Bool)
    /// Закрыть экран
    func dismiss()
    /// Закрыть экран с установкой анимации
    func dismiss(animated: Bool)
    /// Показать экран через push
    func push(_ module: PresentableType?)
    /// Показать экран через push с установкой анимации
    func push(_ module: PresentableType?, animated: Bool)
    /// Показать экран через push с установкой анимации и скрыть TabBar
    func pushAndHideTabBarIfNeeded(_ module: PresentableType?, animated: Bool)
    /// Вернуться назад
    func pop()
    /// Вернуться назад с установкой анимации
    func pop(animated: Bool)
    /// Вернуться к главному экрану  с установкой анимации
    func popToRoot(animated: Bool)
    /// Вернуться назад через все экраны  с установкой анимации
    func popAll(animated: Bool)
}
