//
//  RepoAggregateRoot.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct RepoAggregateRoot {
  private(set) var page: Int
  private(set) var hasNext: Bool
  private(set) var repositoryIDs: [String]
  private(set) var repositoriesByID: [String: RepoAggregate]
  private(set) var ownersByID: [String: UserAggregate]

  var repositories: [RepoAggregate] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  init() {
    self.page = 1
    self.hasNext = false
    self.repositoryIDs = []
    self.repositoriesByID = [:]
    self.ownersByID = [:]
  }

  mutating func set(response: SearchRepositoryResponse, hasNext: Bool) {
    self.page += 1
    self.hasNext = hasNext
    self.repositoryIDs = response.items.map { $0.id.description }
    self.repositoriesByID = response.items.reduce(into: [String: RepoAggregate]()) { $0[$1.id.description] = RepoAggregate(response: $1) }
    self.ownersByID = response.items.reduce(into: [String: UserAggregate]()) { $0[$1.owner.id.description] = UserAggregate(response: $1.owner) }
  }

  mutating func append(response: SearchRepositoryResponse, hasNext: Bool) {
    self.page += 1
    self.hasNext = hasNext
    self.repositoryIDs.append(contentsOf: response.items.map { $0.id.description })
    response.items.forEach {
      self.repositoriesByID[$0.id.description] = RepoAggregate(response: $0)
      self.ownersByID[$0.owner.id.description] = UserAggregate(response: $0.owner)
    }
  }
}
