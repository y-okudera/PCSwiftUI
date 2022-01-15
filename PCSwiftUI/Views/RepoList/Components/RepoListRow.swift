//
//  RepoListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepoListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var repository: RepoAggregate
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(repository.fullName)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct RepoListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepoListRow(repository: RepoAggregate.mock, action: {})
          .preferredColorScheme($0)
      }
    }
  }
#endif
