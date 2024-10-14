//
//  ServiceLocator.swift
//  2024GnewsApp
//
//  Created by borispolevoj on 07.10.2024.
//

import Foundation

public protocol ServiceLocating {
    func resolve<T>() -> T?
}

open class ServiceLocator: ServiceLocating {
    public static let shared = ServiceLocator()

    private lazy var services = [String: Any]()
  
    private init() {}

    private func typeName(_ some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(type(of: some))"
    }

    public func register<T>(service: T) {
        let key = typeName(T.self)
        services[key] = service
    }

    public func resolve<T>() -> T? {
        let key = typeName(T.self)
        return services[key] as? T
    }
}
