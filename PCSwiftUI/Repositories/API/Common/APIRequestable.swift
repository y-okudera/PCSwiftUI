//
//  APIRequestable.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/06.
//

import Foundation
import Request

protocol APIRequestable {
    associatedtype Response: Decodable

    var baseUrl: String { get }
    var path: String { get }
    var method: MethodType { get }

    var queryItems: [URLQueryItem]? { get }
    var bodyItems: [String: Any]? { get }
}

extension APIRequestable {
    var baseUrl: String {
        return "https://api.github.com"
    }

    var queryItems: [URLQueryItem]? {
        return nil
    }

    var bodyItems: [String: Any]? {
        return nil
    }
}
