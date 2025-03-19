// Copyright 2023–2025 Skip
@testable import SwiftJNI
import XCTest

final class SwiftJNITests: XCTestCase {
    func testSwiftJNI() throws {
        #if os(iOS)
        throw XCTSkip("skipping test due to no JVM on iOS")
        #endif

        try JNI.attachJVM(launch: true)

        let integerClass = try JClass(name: "java/lang/Integer", systemClass: true)

        let integerInit = try XCTUnwrap(integerClass.getMethodID(name: "<init>", sig: "(I)V"))
        let integerInstance = try integerClass.create(ctor: integerInit, options: [], args: [JavaParameter(i: .max)])

        let integerIntValue = try XCTUnwrap(integerClass.getMethodID(name: "intValue", sig: "()I"))
        let i: Int32 = try integerInstance.call(method: integerIntValue, options: [], args: [])

        XCTAssertEqual(2147483647, i)
    }
}
