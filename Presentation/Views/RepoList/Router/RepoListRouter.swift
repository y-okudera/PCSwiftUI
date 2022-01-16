//
//  RepoListRouter.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/14.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Foundation

protocol RepoListRouter: Router {
  func navigateToRepositoryOwner(urlString: String)
}

final class RepoListRouterImpl: Router, RepoListRouter {

  func navigateToRepositoryOwner(urlString: String) {
    let router = Router(isPresented: isNavigating)
    navigateTo(
      RepositoryOwnerWebView(urlString: urlString, router: router)
    )
  }
}
