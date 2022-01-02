//
//  Animation+.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/02.
//  Copyright © 2022 yuoku. All rights reserved.
//

import Lottie
import UIKit

extension Lottie.Animation {
  static func asset(
    _ name: String,
    bundle: Bundle = Bundle.main,
    animationCache: AnimationCacheProvider? = nil
  ) -> Lottie.Animation? {
    let cacheKey = bundle.bundlePath + "/" + name

    if let animationCache = animationCache,
      let animation = animationCache.animation(forKey: cacheKey)
    {
      return animation
    }

    guard let json = NSDataAsset(name: name, bundle: bundle)?.data else {
      return nil
    }

    do {
      let animation = try JSONDecoder().decode(Animation.self, from: json)
      animationCache?.setAnimation(animation, forKey: cacheKey)
      return animation
    } catch {
      return nil
    }
  }
}
