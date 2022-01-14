//
//  RepositoryOwnerWebView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryOwnerWebView: View {
  var urlString: String?
  private let router: Router

  init(urlString: String?, router: Router) {
    self.urlString = urlString
    self.router = router
  }

  var body: some View {
    WebView(urlString: urlString ?? "")
  }
}

#if DEBUG
  struct RepositoryOwnerWebView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryOwnerWebView(urlString: Repository.mock.owner.htmlUrl.absoluteString, router: Router(isPresented: .constant(false)))
          .preferredColorScheme($0)
      }
    }
  }
#endif
