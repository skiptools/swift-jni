// swift-tools-version: 5.9
import PackageDescription

let jniDependency: Target.Dependency
let swiftSettings: [SwiftSetting]

let useSwiftJavaJNICore = Context.environment["SWIFT_JAVA_JNI_CORE"] ?? "0" == "1"

if useSwiftJavaJNICore {
    // use swift-java-jni-core
    jniDependency = .product(name: "SwiftJavaJNICore", package: "swift-java-jni-core")
    swiftSettings = [.define("SWIFT_JAVA_JNI_CORE")]

} else {
    jniDependency = .target(name: "CJNI")
    swiftSettings = []
}

let package = Package(
    name: "swift-jni",
    products: [
        .library(name: "SwiftJNI", type: .dynamic, targets: ["SwiftJNI"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "CJNI"),
        .target(name: "SwiftJNI", dependencies: [
            jniDependency,
        ], swiftSettings: swiftSettings),
        .testTarget(name: "SwiftJNITests", dependencies: [
            "SwiftJNI"
        ], swiftSettings: swiftSettings),
    ]
)

if useSwiftJavaJNICore {
    package.dependencies += [
        .package(url: "https://github.com/swiftlang/swift-java-jni-core.git", from: "0.4.0"),
    ]
}
