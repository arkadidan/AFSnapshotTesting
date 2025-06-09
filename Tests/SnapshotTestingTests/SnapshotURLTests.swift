//
//  SnapshotURLTests.swift
//  AFSnapshotTesting
//
//  Created by arkadi.daniyelian on 6/9/25.
//

import XCTest
@testable import AFSnapshotTesting

final class SnapshotURLTests: XCTestCase {

    func testCreateReferenceUrl() {
        let url = Snapshot.createReferenceURL(name: "testName", class: "className", inDirectory: URL(string: "Volumes/workspace/repository/ci_scripts/")!)

        XCTAssertEqual(url.absoluteString, "Volumes/workspace/repository/ci_scripts/Snapshots/className/testName.png")
    }

//    func testCreateReferenceUrlFile() {
//        // file:///Users/arkadzi.daniyelian/S/AFSnapshotTesting/Tests/SnapshotTestingTests/Snapshots/ComplexViewTests/testComplex.png
//        let expectedDirUrl = URL(fileURLWithPath: String(describing: #file))
//            .deletingLastPathComponent()
//
//
//        let url = Snapshot.createReferenceURL(name: "testName", class: "className", file: #file)
//
//        XCTAssertEqual(url.absoluteString, expectedDirUrl.absoluteString + "Snapshots/className/testName.png")
//
//        XCTAssertEqual(url.absoluteString, "file:///Users/arkadzi.daniyelian/S/AFSnapshotTesting/Tests/SnapshotTestingTests/Snapshots/className/testName.png")
//    }

    func testCreateDifferenceImageUrl() {
        let url = Snapshot.createDifferenceImageURL(name: "testName", class: "className", inDirectory: URL(string: "Volumes/workspace/repository/ci_scripts/")!)

        XCTAssertEqual(url.absoluteString, "Volumes/workspace/repository/ci_scripts/Difference/className/testName.png")
    }

//    func testCreateDifferenceUrl() {
//        let expectedDirUrl = URL(fileURLWithPath: String(describing: #file))
//            .deletingLastPathComponent()
//
//
//        let url = Snapshot.createReferenceURL(name: "testName", class: "className", file: #file)
//
//        XCTAssertEqual(url.absoluteString, expectedDirUrl.absoluteString + "Snapshots/className/testName.png")
//    }
}
