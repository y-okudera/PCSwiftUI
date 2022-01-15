//
//  RepoAggregateRoot.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct RepoAggregateRoot {
  let page: Int
  let hasNext: Bool
  let repositoryIDs: [String]
  let repositoriesByID: [String: RepoAggregate]
  let ownersByID: [String: UserAggregate]

  var repositories: [RepoAggregate] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  init(
    page: Int,
    hasNext: Bool,
    repositoryIDs: [String],
    repositoriesByID: [String: RepoAggregate],
    ownersByID: [String: UserAggregate]
  ) {
    self.page = page
    self.hasNext = hasNext
    self.repositoryIDs = repositoryIDs
    self.repositoriesByID = repositoriesByID
    self.ownersByID = ownersByID
  }

  init() {
    self.init(page: 1, hasNext: false, repositoryIDs: [], repositoriesByID: [:], ownersByID: [:])
  }

  mutating func set(response: SearchRepositoryResponse, hasNext: Bool) {
    let page = self.page + 1
    let repositoryIDs = response.items.map { $0.id.description }
    let repositoriesByID = response.items.reduce(into: [String: RepoAggregate]()) { $0[$1.id.description] = RepoAggregate(response: $1) }
    let ownersByID = response.items.reduce(into: [String: UserAggregate]()) { $0[$1.owner.id.description] = UserAggregate(response: $1.owner) }

    self = .init(page: page, hasNext: hasNext, repositoryIDs: repositoryIDs, repositoriesByID: repositoriesByID, ownersByID: ownersByID)
  }

  mutating func append(response: SearchRepositoryResponse, hasNext: Bool) {
    let page = self.page + 1
    let repositoryIDs = self.repositoryIDs + response.items.map { $0.id.description }
    let repositoriesByID: [String: RepoAggregate] = {
      var repositoriesByID = self.repositoriesByID
      response.items.forEach { repositoriesByID[$0.id.description] = RepoAggregate(response: $0) }
      return repositoriesByID
    }()

    let ownersByID: [String: UserAggregate] = {
      var ownersByID = self.ownersByID
      response.items.forEach { ownersByID[$0.owner.id.description] = UserAggregate(response: $0.owner) }
      return ownersByID
    }()

    self = .init(page: page, hasNext: hasNext, repositoryIDs: repositoryIDs, repositoriesByID: repositoriesByID, ownersByID: ownersByID)
  }
}
