//
//  GitHubRepository.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct GitHubRepository: Decodable {
  public var id: Int64
  public var fullName: String
  public var description: String?
  public var stargazersCount: Int = 0
  public var language: String?
  public var owner: GitHubUser
}
