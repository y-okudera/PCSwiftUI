//
//  Error+.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

extension Error {
  var reflectedString: String {
    return String(reflecting: self)
  }

  func isEqual(to: Error) -> Bool {
    return reflectedString == to.reflectedString
  }
}
