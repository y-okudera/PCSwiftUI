//
//  RepositoryListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @EnvironmentObject private var screenCoordinator: ScreenCoordinator

  @State var repository: Repository

  var body: some View {
    Button {
      screenCoordinator.selectedPushedItem = .repositoryOwnerWebView(url: repository.owner.htmlUrl)
    } label: {
      Text(repository.fullName)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
    .background(
      NavigationLink(
        destination: RepositoryOwnerWebView(htmlUrl: repository.owner.htmlUrl),
        tag: ScreenCoordinator.PushedItem.repositoryOwnerWebView(url: repository.owner.htmlUrl),
        selection: $screenCoordinator.selectedPushedItem,
        label: {
          EmptyView()
        }
      )
    )
  }
}

#if DEBUG
  struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
      RepositoryListRow(
        repository: Repository(
          id: 1_300_192.description,
          fullName: "octocat/Spoon-Knife",
          description: "This repo is for demonstration purposes only.",
          stargazersCount: 10673,
          language: "HTML",
          owner: User(
            id: 583231.description,
            login: "octocat",
            avatarUrl: URL(string: "https://avatars.githubusercontent.com/u/583231?v=4")!,
            htmlUrl: URL(string: "https://github.com/octocat")!
          )
        )
      )
    }
  }
#endif
