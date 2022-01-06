//
//  User.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation
import SwiftUI

struct User: Decodable, Hashable, Identifiable {
  var id: Int64
  var login: String
  var avatarUrl: URL
  var htmlUrl: String
}
