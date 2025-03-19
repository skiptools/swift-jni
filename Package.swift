// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "swift-jni",
    products: [
        .library(name: "SwiftJNI", targets: ["SwiftJNI"]),
    ],
    targets: [
        .target(name: "CJNI"),
        .target(name: "SwiftJNI", dependencies: ["CJNI"]),
        .testTarget(name: "SwiftJNITests", dependencies: ["SwiftJNI"]),
    ]
)
