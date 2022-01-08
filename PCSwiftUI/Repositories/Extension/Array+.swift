//
//  Array+.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

extension Array {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
