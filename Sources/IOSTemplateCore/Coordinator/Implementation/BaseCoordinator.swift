//
//  BaseCoordinator.swift
//
//  Created by Oleg Ben.
//

import Foundation

/// Основной координатор
open class BaseCoordinator: NSObject, CoordinatorType {
    /// Координаторы
    var childCoordinators: [CoordinatorType] = []
    
    public private(set) var router: RouterType?
    
    /// метод для установки зависимости на роутер
    /// - Parameter _router: класс обертка вокруг UINavigationControlller для сокрытия методов навигации
    public func set(_ router: RouterType) {
        self.router = router
    }
    
    /// Старт
    open func start() {
        
    }
    
    public func cleanDependency() {
        self.childCoordinators.removeAll()
    }
    
    /// Добавление зависимостей
    /// - Parameter coordinator: Координатор
    public func addDependency(_ coordinator: CoordinatorType) {
        for element in self.childCoordinators {
            if element === coordinator { return }
        }
        self.childCoordinators.append(coordinator)
    }
    
    /// Удаление зависимостей
    /// - Parameter coordinator: coordinator Координатор
    public func removeDependency(_ coordinator: CoordinatorType?) {
        guard self.childCoordinators.isEmpty == false, coordinator != nil else { return }
        for (index, element) in self.childCoordinators.enumerated() {
            if element === coordinator! {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    /// Возвращает зависимости заданного типа
    ///  - Parameters:
    ///   - dependencyType: тип для поиска в зависимостях
    /// - Returns: опциональный элемент с заданным типом
    public func getDependencyOfType<T>(_ dependencyType: T.Type) -> T? {
        for element in self.childCoordinators {
            if let _element = element as? T {
                return _element
            }
        }
        return nil
    }
}
