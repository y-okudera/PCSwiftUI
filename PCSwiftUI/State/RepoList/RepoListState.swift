//
//  RepoListState.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/08.
//

import Foundation

struct RepoListState {
  var repositoryIDs: [String]
  var repositoriesByID: [String: Repository]
  var ownersByID: [String: User]

  var repositories: [Repository] {
    repositoryIDs.compactMap { repositoriesByID[$0] }
  }

  init() {
    self.repositoryIDs = []
    self.repositoriesByID = [:]
    self.ownersByID = [:]
  }

  init(response: SearchRepositoryResponse) {
    self.repositoryIDs = response.items.map { $0.id.description }
    self.repositoriesByID = response.items.reduce(into: [String: Repository]()) { $0[$1.id.description] = Repository(response: $1) }
    self.ownersByID = response.items.reduce(into: [String: User]()) { $0[$1.owner.id.description] = User(response: $1.owner) }
  }

  mutating func append(response: SearchRepositoryResponse) {
    self.repositoryIDs.append(contentsOf: response.items.map { $0.id.description })
    response.items.forEach {
      self.repositoriesByID[$0.id.description] = Repository(response: $0)
      self.ownersByID[$0.owner.id.description] = User(response: $0.owner)
    }
  }
}
