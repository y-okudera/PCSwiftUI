//
//  UserListState.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct UserListState {
  var hasNext: Bool
  var userIDs: [String]
  var usersByID: [String: User]

  var users: [User] {
    userIDs.compactMap { usersByID[$0] }
  }

  init() {
    self.hasNext = false
    self.userIDs = []
    self.usersByID = [:]
  }

  init(response: SearchUserResponse) {
    self.hasNext = response.incompleteResults
    self.userIDs = response.items.map { $0.id.description }
    self.usersByID = response.items.reduce(into: [String: User]()) { $0[$1.id.description] = User(response: $1) }
  }

  mutating func append(response: SearchUserResponse) {
    self.hasNext = response.incompleteResults
    self.userIDs.append(contentsOf: response.items.map { $0.id.description })
    response.items.forEach {
      self.usersByID[$0.id.description] = User(response: $0)
    }
  }
}
