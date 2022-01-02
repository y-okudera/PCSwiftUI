//
//  Bundle+.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/02.
//

import Foundation

extension Bundle {
  static var current: Bundle {
    class DummyClass {}
    return Bundle(for: type(of: DummyClass()))
  }
}
