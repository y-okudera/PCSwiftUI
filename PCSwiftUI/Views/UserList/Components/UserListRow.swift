//
//  UserListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

struct UserListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var user: UserAggregate
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      Text(user.login)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct UserListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        UserListRow(user: UserAggregate.mock, action: {})
          .preferredColorScheme($0)
      }
    }
  }
#endif
