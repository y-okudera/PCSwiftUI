// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SubTools",
  dependencies: [
    .package(url: "https://github.com/yonaskolb/XcodeGen", .exact("2.25.0")),
  ],
  targets: [
    .target(name: "SubTools", path: ""),
  ]
)
