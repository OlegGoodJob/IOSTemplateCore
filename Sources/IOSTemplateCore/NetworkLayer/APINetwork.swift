//
//  APINetwork.swift
//
//  Created by Oleg Ben.
//

import Foundation
import Combine

// MARK: APINetwork
/// Протокол менеджера для выполнения запросов
public protocol APINetwork {
    /// Метод выполнения запроса с парсом ответа в предоставленную модель данных
    /// - Parameters:
    ///   - gateway: Gateway
    ///   - model: Модель данных
    func request<M: Codable>(gateway: Gateway, model: M.Type) -> Future<M, Error>
}

// MARK: APINetworkImpl
/// Реализация менеджера для выполнения запросов
public final class APINetworkImpl: APINetwork {
    /// Менеджер запроса
    private var urlSession = URLSession(configuration: .default)
    /// Кэширование изображений
    private var cashedImages: [String: Data] = [:]
    
    
    /// Метод выполнения запроса с парсом ответа в предоставленную модель данных
    /// - Parameters:
    ///   - gateway: Gateway
    ///   - model: Модель данных
    /// - Returns: Future<Результат, Ошибка>
    public func request<M: Codable>(gateway: Gateway, model: M.Type) -> Future<M, Error> {
        return Future { [weak self] (promise) in
            guard let _self = self,
                  var urlComponents = URLComponents(string: gateway.apiVersion + gateway.url) else {
                return
            }
            
            /// Запись параметров
            switch gateway.method {
            case .get:
                var queryItems: [URLQueryItem] = []
                for (key, value) in gateway.params {
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
                urlComponents.queryItems = queryItems
            }
            /// Получение URL
            guard let url = urlComponents.url else { return }
            /// Создание и настройка запроса
            var request = URLRequest(url: url)
            request.httpMethod = gateway.method.rawValue
            request.allHTTPHeaderFields = gateway.headers
            
            /// Отправка запроса для получения данных
            _self.urlSession.dataTask(with: request) { (data, response, error) in
                if let _error = error {
                    promise(.failure(_error))
                } else if let _data = data {
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(model, from: _data)
                        promise(.success(result))
                    } catch(let error) {
                        promise(.failure(error))
                    }
                }
            }
            .resume()
        }
    }
}
