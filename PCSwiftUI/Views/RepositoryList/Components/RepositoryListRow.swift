//
//  RepositoryListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/05.
//

import SwiftUI

struct RepositoryListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var repository: Repository
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(repository.fullName)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct RepositoryListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepositoryListRow(repository: Repository.mock, action: {})
          .preferredColorScheme($0)
      }
    }
  }
#endif
