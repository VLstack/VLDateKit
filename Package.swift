// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(name: "VLDateKit",
                      platforms: [ .iOS(.v17) ],
                      products:
                      [
                       .library(name: "VLDateKit",
                                targets: ["VLDateKit"])
                      ],
                      targets:
                      [
                       .target(name: "VLDateKit"),
                       .testTarget(name: "VLDateKitTests",
                                   dependencies: ["VLDateKit"])
                      ])
