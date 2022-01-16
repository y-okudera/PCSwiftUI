//
//  ActivityIndicator.swift
//  Presentation
//
//  Created by Yuki Okudera on 2022/01/09.
//  Copyright © 2022 yuoku. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
  func makeUIView(context: Context) -> UIActivityIndicatorView {
    UIActivityIndicatorView(style: .medium)
  }

  func updateUIView(_ activityIndicatorView: UIActivityIndicatorView, context: Context) {
    activityIndicatorView.startAnimating()
  }
}

#if DEBUG
  struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
      ForEach(ColorScheme.allCases, id: \.self) {
        ActivityIndicator()
          .preferredColorScheme($0)
      }
    }
  }
#endif
