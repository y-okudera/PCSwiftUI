//
//  APIError.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

enum APIError: Error {
  case responseError(Error)
  case parseError(Error)
}
