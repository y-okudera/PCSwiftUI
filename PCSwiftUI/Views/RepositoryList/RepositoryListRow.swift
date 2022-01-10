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
      screenCoordinator.selectedUserPageUrl = ScreenCoordinator.Selection(isSelected: true, item: repository.owner.htmlUrl.absoluteString)
    } label: {
      Text(repository.fullName)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryListRow(repository: Repository.mock)
          .environmentObject(ScreenCoordinator())
          .preferredColorScheme($0)
      }
    }
  }
#endif
