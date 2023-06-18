//
//  Gateway.swift
//
//  Created by Oleg Ben.
//

import Foundation

// MARK: Gateway
public protocol Gateway {
    /// Ссылка
    var url: String { get }
    /// Метод
    var method: APIMethod { get }
    /// Версия API
    var apiVersion: String { get }
    /// Заголовки
    var headers: [String: String] { get }
    /// Параметры
    var params: [String: String] { get }
}
