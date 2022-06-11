// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "swiftwasm",
    dependencies: [
    ],
    targets: [
      .executableTarget(name: "swiftwasm", dependencies: [
      ]),
      .testTarget(
            name: "swiftwasmTests",
            dependencies: ["swiftwasm"]
      ),
    ]
)