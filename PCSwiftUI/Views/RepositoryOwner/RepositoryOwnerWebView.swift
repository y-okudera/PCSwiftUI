//
//  RepositoryOwnerWebView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryOwnerWebView: View {
  var htmlUrl: URL

  var body: some View {
    WebView(urlString: htmlUrl.absoluteString)
  }
}

#if DEBUG
  struct RepositoryOwnerWebView_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryOwnerWebView(htmlUrl: Repository.mock.owner.htmlUrl)
          .preferredColorScheme($0)
      }
    }
  }
#endif
