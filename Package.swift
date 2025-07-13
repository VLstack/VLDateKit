// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLDateKit",
                      defaultLocalization: "en",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLDateKit",
                                targets: [ "VLDateKit" ])
                      ],
                      dependencies:
                      [
                       .package(url: "https://github.com/VLstack/VLstackNamespace", from: "1.2.0")
                      ],
                      targets:
                      [
                       .target(name: "VLDateKit",
                               dependencies: [ "VLstackNamespace" ]),
                       .testTarget(name: "VLDateKitTests",
                                   dependencies: [ "VLstackNamespace", "VLDateKit" ])
                      ])
