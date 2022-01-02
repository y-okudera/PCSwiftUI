//
//  AppDelegateCore.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import ComposableArchitecture
import SwiftUI

public enum AppDelegateCore {
  // MARK: - State

  public struct State: Equatable {
    public init() {}
  }

  // MARK: - Action

  public enum Action: Equatable {
    case didFinishLaunching
  }

  // MARK: - Environment

  public struct Environment {
    var localDatabaseClient: LocalDatabaseClient
  }

  // MARK: - Reducer

  public static let reducer =
    Reducer<State, Action, Environment> { _, action, _ in
      switch action {
      case .didFinishLaunching:
        print(".didFinishLaunching")
        return .none
      }
    }
}
