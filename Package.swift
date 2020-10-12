// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "FatturaElettronica-Swift",
    platforms: [.macOS(.v10_15)],
    products: [
        .library(
            name: "FatturaElettronica",
            targets: ["FatturaElettronica"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", from: "0.11.1")
    ],
    targets: [
        .target(
            name: "FatturaElettronica",
            dependencies: [
                .product(name: "XMLCoder", package: "XMLCoder"), .product(name: "NIO", package: "swift-nio"),
            ],
            swiftSettings: [.unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))]
        ),
        .testTarget(
            name: "AppTests",
            dependencies: ["FatturaElettronica"]),
    ]
)
