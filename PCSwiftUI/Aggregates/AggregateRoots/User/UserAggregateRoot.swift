//
//  UserAggregateRoot.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

struct UserAggregateRoot {
  let page: Int
  let hasNext: Bool
  let userIDs: [String]
  let usersByID: [String: UserAggregate]

  var users: [UserAggregate] {
    userIDs.compactMap { usersByID[$0] }
  }

  init(page: Int, hasNext: Bool, userIDs: [String], usersByID: [String: UserAggregate]) {
    self.page = page
    self.hasNext = hasNext
    self.userIDs = userIDs
    self.usersByID = usersByID
  }

  init() {
    self.init(page: 1, hasNext: false, userIDs: [], usersByID: [:])
  }

  mutating func set(response: SearchUserResponse, hasNext: Bool) {
    let page = self.page + 1
    let userIDs = response.items.map { $0.id.description }
    let usersByID = response.items.reduce(into: [String: UserAggregate]()) { $0[$1.id.description] = UserAggregate(response: $1) }
    self = .init(page: page, hasNext: hasNext, userIDs: userIDs, usersByID: usersByID)
  }

  mutating func append(response: SearchUserResponse, hasNext: Bool) {
    let page = self.page + 1
    let userIDs = self.userIDs + response.items.map { $0.id.description }
    let usersByID: [String: UserAggregate] = {
      var usersByID = self.usersByID
      response.items.forEach {
        usersByID[$0.id.description] = UserAggregate(response: $0)
      }
      return usersByID
    }()
    self = .init(page: page, hasNext: hasNext, userIDs: userIDs, usersByID: usersByID)
  }
}
