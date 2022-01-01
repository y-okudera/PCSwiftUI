// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MainTools",
  dependencies: [
    .package(url: "https://github.com/mono0926/LicensePlist", .exact("3.16.0")),
    .package(url: "https://github.com/SwiftGen/SwiftGen", .exact("6.5.1")),
    .package(url: "https://github.com/realm/SwiftLint", .exact("0.40.3")),
  ],
  targets: [
    .target(name: "MainTools", path: ""),
  ]
)
