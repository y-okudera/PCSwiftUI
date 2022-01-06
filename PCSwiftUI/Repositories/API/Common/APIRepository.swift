//
//  APIRepository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Combine
import Foundation
import Json
import Request

protocol APIRepositoryProviding {
    func response<T: APIRequestable>(from apiRequest: T) -> AnyPublisher<T.Response, APIError>
}

final class APIRepository: APIRepositoryProviding {

    private let baseURL: URL
    init(baseURL: URL = URL(string: "https://api.github.com")!) {
        self.baseURL = baseURL
    }

    func response<T: APIRequestable>(from apiRequest: T) -> AnyPublisher<T.Response, APIError> {
        let decorder = JSONDecoder()
        decorder.keyDecodingStrategy = .convertFromSnakeCase

        print(apiRequest.baseUrl + apiRequest.path)
        return Request {
            Url(apiRequest.baseUrl + apiRequest.path)
            Header.Accept(.json)
            Timeout(60, for: .request)
            Timeout(30, for: .resource)

            if let queryItems = apiRequest.queryItems {
                Query(queryItems.compactMap { $0.value == nil ? nil : .init($0.name, value: $0.value!) })
            }
            if let bodyItems = apiRequest.bodyItems {
                Body(bodyItems)
            }
        }
        .map(\.data)
        .mapError(APIError.responseError)
        .decode(type: T.Response.self, decoder: decorder)
        .mapError(APIError.parseError)
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
