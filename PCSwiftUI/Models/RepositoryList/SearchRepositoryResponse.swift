//
//  SearchRepositoryResponse.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import Foundation

struct SearchRepositoryResponse: Decodable {
    var items: [Repository]
}
