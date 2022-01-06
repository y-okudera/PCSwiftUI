//
//  Repository.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation
import SwiftUI

struct Repository: Decodable, Hashable, Identifiable {
  var id: Int64
  var fullName: String
  var description: String?
  var stargazersCount: Int = 0
  var language: String?
  var owner: User
}
