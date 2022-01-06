//
//  APIRepositoryProviderKey.swift
//  PCSwiftUI
//
//  Created by okudera on 2022/01/06.
//

import Foundation

private struct APIRepositoryProviderKey: InjectionKey {
    static var currentValue: APIRepositoryProviding = APIRepository()
}

extension InjectedValues {
    var apiRepositoryProvider: APIRepositoryProviding {
        get { Self[APIRepositoryProviderKey.self] }
        set { Self[APIRepositoryProviderKey.self] = newValue }
    }
}
