//
//  UserListRow.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/10.
//

import SwiftUI

struct UserListRow: View {
  @Environment(\.colorScheme) private var colorScheme

  @State var user: User

  var body: some View {
    Button {
      #warning("Will impl transition.")
      print("Selected User: \(user.login)")
    } label: {
      Text(user.login)
        .foregroundColor(colorScheme == .light ? .black : .white)
    }
  }
}

#if DEBUG
  struct UserListRow_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        UserListRow(user: User.mock)
          .preferredColorScheme($0)
      }
    }
  }
#endif
