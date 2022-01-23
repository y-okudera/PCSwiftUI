//
//  UserListRow.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/10.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Kingfisher
import SwiftUI

struct UserListRow: View {
  @Environment(\.colorScheme) private var colorScheme
  @State var title: String
  @State var avatarUrl: URL
  let action: () -> Void

  var body: some View {
    Button(action: action) {
      HStack {
        KFImage(avatarUrl)
          .cacheOriginalImage()
          .placeholder { ProgressView() }
          .fade(duration: 0.5)
          .resizable()
          .frame(width: 44, height: 44)
          .cornerRadius(22)
          .shadow(color: colorScheme == .light ? .gray : .clear, radius: 2)
        Text(title)
          .foregroundColor(colorScheme == .light ? .black : .white)
      }
    }
  }
}

#if DEBUG
  struct UserListRow_Previews: PreviewProvider {
    static var previews: some View {
      let previewContentPath = Bundle.current.path(forResource: "octocat", ofType: "png")!
      ForEach(ColorScheme.allCases, id: \.self) {
        UserListRow(
          title: "octocat",
          avatarUrl: URL(fileURLWithPath: previewContentPath),
          action: {}
        )
        .preferredColorScheme($0)
      }
    }
  }
#endif
