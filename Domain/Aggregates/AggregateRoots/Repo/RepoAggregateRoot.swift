//
//  RepoAggregateRoot.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct RepoAggregateRoot {
  public let page: Int
  public let hasNext: Bool
  public let repositoryIDs: [String]
  public let repositoriesByID: [String: RepoAggregate]
  public let ownersByID: [String: UserAggregate]

  public var repositories: [RepoAggregate] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  public init(
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

  public init() {
    self.init(page: 1, hasNext: false, repositoryIDs: [], repositoriesByID: [:], ownersByID: [:])
  }

  public mutating func set(oldValue: RepoAggregateRoot, newValue: RepoAggregateRoot) {
    let repositoryIDs = oldValue.repositoryIDs + newValue.repositoryIDs
    let repositoriesByID = oldValue.repositoriesByID.merging(newValue.repositoriesByID) { $1 }
    let ownersByID = oldValue.ownersByID.merging(newValue.ownersByID) { $1 }

    self = .init(
      page: newValue.page,
      hasNext: newValue.hasNext,
      repositoryIDs: repositoryIDs,
      repositoriesByID: repositoriesByID,
      ownersByID: ownersByID
    )
  }
}
