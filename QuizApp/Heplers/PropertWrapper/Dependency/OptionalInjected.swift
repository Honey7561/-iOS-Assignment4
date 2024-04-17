//
//  OptionalInjected.swift
//  SwiftBoilerPlate
//
//  Created by user238851 on 13/04/24.
//

import Foundation

@propertyWrapper
public class OptionalInjected<Service> {
    public var wrappedValue: Service?

    public init(resolver: Resolver = .default, tag: String? = nil) {
        wrappedValue = resolver.resolve(type: Service.self, tag: tag)
    }
}
