//
//  RepoAggregate.swift
//  Domain
//
//  Created by Yuki Okudera on 2022/01/08.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct RepoAggregate: Decodable, Hashable, Identifiable {
  public let id: String
  public let fullName: String
  public let description: String?
  public let stargazersCount: Int
  public let language: String?
  public let owner: UserAggregate

  public init(
    id: String,
    fullName: String,
    description: String?,
    stargazersCount: Int,
    language: String?,
    owner: UserAggregate
  ) {
    self.id = id
    self.fullName = fullName
    self.description = description
    self.stargazersCount = stargazersCount
    self.language = language
    self.owner = owner
  }
}

// MARK: - Mock
extension RepoAggregate {
  public static var mock: Self {
    return Self(
      id: 1_300_192.description,
      fullName: "octocat/Spoon-Knife",
      description: "This repo is for demonstration purposes only.",
      stargazersCount: 10673,
      language: "HTML",
      owner: UserAggregate(
        id: 583231.description,
        login: "octocat",
        avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
        htmlUrl: URL(string: "https://github.com/octocat")!
      )
    )
  }
}
