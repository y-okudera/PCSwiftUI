//
//  InjectionKey.swift
//  PCSwiftUI
//
//  Created by okudera on 2022/01/06.
//

import Foundation

public protocol InjectionKey {

  /// The associated type representing the type of the dependency injection key's value.
  associatedtype Value

  /// The default value for the dependency injection key.
  static var currentValue: Value { get set }
}
