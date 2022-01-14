//
//  RepositoryListRouter.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/14.
//

import Foundation

protocol RepositoryListRouter: Router {
  func navigateToRepositoryOwner(urlString: String)
}

final class RepositoryListRouterImpl: Router, RepositoryListRouter {

  func navigateToRepositoryOwner(urlString: String) {
    let router = Router(isPresented: isNavigating)
    navigateTo(
      RepositoryOwnerWebView(urlString: urlString, router: router)
    )
  }
}
