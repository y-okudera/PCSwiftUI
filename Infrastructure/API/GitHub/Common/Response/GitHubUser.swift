//
//  GitHubUser.swift
//  Infrastructure
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct GitHubUser: Decodable {
  public var id: Int64
  public var login: String
  public var avatarUrl: URL
  public var htmlUrl: URL
}
