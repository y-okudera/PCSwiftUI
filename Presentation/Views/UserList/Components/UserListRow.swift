//
//  UserListRow.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct UserListRow: View {
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
  struct UserListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        UserListRow(title: "octocat", action: {})
          .preferredColorScheme($0)
      }
    }
  }
#endif
