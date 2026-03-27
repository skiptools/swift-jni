// Copyright 2023–2025 Skip
@testable import SwiftJNI
import Testing

@Suite struct SwiftJNITests {
    @Test func testSwiftJNI() throws {
        try JNI.attachJVM(launch: true)

        let integerClass = try JClass(name: "java/lang/Integer", systemClass: true)

        let integerInit = try #require(integerClass.getMethodID(name: "<init>", sig: "(I)V"))
        let integerInstance = try integerClass.create(ctor: integerInit, options: [], args: [JavaParameter(i: .max)])

        let integerIntValue = try #require(integerClass.getMethodID(name: "intValue", sig: "()I"))
        let i: Int32 = try integerInstance.call(method: integerIntValue, options: [], args: [])

        #expect(i == 2147483647, "Int.MAX_VALUE should be 32-bit")
    }
}
