//
//  APIRouter.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

enum APIRouter {
  static func request(for route: APIRoute) -> URLRequest {
    var request = URLRequest(url: route.url)
    request.httpMethod = route.httpMethod
    return request
  }

  static func url(for route: APIRoute) -> URL {
    route.url
  }
}
