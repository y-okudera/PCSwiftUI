//
//  Cards.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

public struct Cards: Decodable, Equatable, Identifiable {
  public var id = UUID()
  public var cards: [Card]

  enum CodingKeys: String, CodingKey {
    case cards
  }
}

// MARK: Mock

extension Cards {
  public static var mock: Cards {
    Cards(
      cards: [
        Card.mock1,
        Card.mock2,
      ]
    )
  }
}
