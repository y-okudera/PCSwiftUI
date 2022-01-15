//
//  UserAggregateRoot.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct UserAggregateRoot {
  private(set) var page: Int
  private(set) var hasNext: Bool
  private(set) var userIDs: [String]
  private(set) var usersByID: [String: UserAggregate]

  var users: [UserAggregate] {
    userIDs.compactMap { usersByID[$0] }
  }

  init() {
    self.page = 1
    self.hasNext = false
    self.userIDs = []
    self.usersByID = [:]
  }

  mutating func set(response: SearchUserResponse, hasNext: Bool) {
    self.page += 1
    self.hasNext = hasNext
    self.userIDs = response.items.map { $0.id.description }
    self.usersByID = response.items.reduce(into: [String: UserAggregate]()) { $0[$1.id.description] = UserAggregate(response: $1) }
  }

  mutating func append(response: SearchUserResponse, hasNext: Bool) {
    self.page += 1
    self.hasNext = hasNext
    self.userIDs.append(contentsOf: response.items.map { $0.id.description })
    response.items.forEach {
      self.usersByID[$0.id.description] = UserAggregate(response: $0)
    }
  }
}
