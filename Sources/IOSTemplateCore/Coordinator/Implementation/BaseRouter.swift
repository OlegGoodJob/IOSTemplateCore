//
//  BaseRouter.swift
//  
//
//  Created by Oleg Ben.
//

import UIKit

/// Реализация роутера
open class RouterImplementation: NSObject, RouterType {
    // MARK: Параметры
    /// Навигационный контроллер
    private weak var navigationViewController: UINavigationController?
    /// Основной контроллер
    private weak var rootViewController: UIViewController?
    
    // MARK: Инициализаторы    
    /// Инициализатор
    /// - Parameter rootViewController: NavigationController
    public init(rootViewController: UINavigationController) {
        super.init()
        self.navigationViewController = rootViewController
        self.rootViewController = rootViewController.viewControllers.last
    }
    
    /// Инициализатор
    /// - Parameter navigationController: NavigationController
    public init(navigationController: UINavigationController) {
        super.init()
        self.navigationViewController = navigationController
        self.rootViewController = navigationController.viewControllers.first
    }
    
    // MARK: Показ через present
    /// Показ UIViewController
    /// - Returns: UIViewController
    public func toPresent() -> UIViewController? {
        return self.navigationViewController
    }
    
    /// Показать экран через present
    /// - Parameter module: Presentable?
    public func present(_ module: PresentableType?) {
        self.present(module, animated: true)
    }
    
    /// Показать экран через present с установкой анимации
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func present(_ module: PresentableType?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.navigationViewController?.present(controller, animated: animated, completion: nil)
    }
    
    // MARK: Закрытие
    /// Закрыть экран
    public func dismiss() {
        self.dismiss(animated: true)
    }
    
    /// Закрыть экран с установкой анимации
    /// - Parameter animated: Bool
    public func dismiss(animated: Bool) {
        self.navigationViewController?.dismiss(animated: animated, completion: nil)
    }
    
    // MARK: Показ через push
    /// Показать экран через push
    /// - Parameter module: Presentable?
    public func push(_ module: PresentableType?) {
        self.push(module, animated: true)
    }
    
    /// Показать экран через push с установкой анимации
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func push(_ module: PresentableType?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        self.navigationViewController?.pushViewController(controller, animated: animated)
    }
    
    /// Показать экран через push с установкой анимации и скрыть TabBar
    /// - Parameters:
    ///   - module: Presentable?
    ///   - animated: Bool
    public func pushAndHideTabBarIfNeeded(_ module: PresentableType?, animated: Bool) {
        guard let controller = module?.toPresent() else { return }
        controller.hidesBottomBarWhenPushed = true
        self.push(controller, animated: animated)
    }
    
    // MARK: Назад через pop
    /// Вернуться назад
    public func pop() {
        self.pop(animated: true)
    }
    
    /// Вернуться назад с установкой анимации
    /// - Parameter animated: Bool
    public func pop(animated: Bool) {
        self.navigationViewController?.popViewController(animated: animated)
    }
    
    /// Вернуться к главному экрану  с установкой анимации
    /// - Parameter animated: Bool
    public func popToRoot(animated: Bool) {
        guard let rootViewController = rootViewController,
              let contains = self.navigationViewController?.viewControllers.contains(rootViewController),
            contains else {
                self.popAll(animated: animated)
            return
        }
        self.navigationViewController?.popToViewController(rootViewController, animated: animated)
    }
    
    /// Вернуться назад через все экраны  с установкой анимации
    /// - Parameter animated: Bool
    public func popAll(animated: Bool) {
        self.navigationViewController?.popToRootViewController(animated: animated)
    }
}
