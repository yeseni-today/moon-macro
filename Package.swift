// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "moon-macro",
  platforms: [.macOS(.v13), .iOS(.v15)],
  products: [
    .library(name: "MoonMacro", targets: ["MoonMacro"]),
  ],
  dependencies: [
    .package(url: "https://github.com/swiftlang/swift-syntax.git", "600.0.0" ..< "602.0.0"),
  ],
  targets: [
    .macro(
      name: "MoonMacroMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .target(name: "MoonMacro", dependencies: ["MoonMacroMacros"]),
    .executableTarget(name: "MacroClient", dependencies: ["MoonMacro"]),
    .testTarget(
      name: "MacroTests",
      dependencies: [
        "MoonMacroMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
      ]
    ),
  ]
)
