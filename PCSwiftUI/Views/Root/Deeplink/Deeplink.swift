//
//  Deeplink.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import Foundation

enum Deeplink {
  case tab(index: Int)

  init?(url: URL) {
    guard url.scheme == "pcswiftui",
      let host = url.host,
      let queryUrlComponents = URLComponents(string: url.absoluteString)
    else {
      return nil
    }

    switch host {
    case "tab":
      if let indexString = queryUrlComponents.queryItems?.first(where: { $0.name == "index" })?.value,
        let index = Int(indexString)
      {
        self = .tab(index: index)
        return
      }
    default:
      return nil
    }
    return nil
  }
}
