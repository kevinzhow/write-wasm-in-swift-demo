// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
    name: "swiftwasm",
    dependencies: [
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.6.0"),
    ],
    targets: [
      .executableTarget(name: "swiftwasm", dependencies: [
        .product(name: "SwiftProtobuf", package: "swift-protobuf")
      ]),
      .testTarget(
            name: "swiftwasmTests",
            dependencies: ["swiftwasm"]
      ),
    ]
)