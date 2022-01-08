//
//  ActivityIndicator.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/09.
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
