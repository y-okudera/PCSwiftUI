//
//  RepoListRow.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/05.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct RepoListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var title: String
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(title)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct RepoListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        RepoListRow(title: "octocat/Spoon-Knife", action: {})
          .preferredColorScheme($0)
      }
    }
  }
#endif
