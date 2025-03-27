//
// DeltaKernelTests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 26.03.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License
//

import XCTest
import Services
@testable import AFSnapshotTesting

final class DeltaKernelTests: XCTestCase {
    let kernel = try! DeltaKernel(with: Kernel.Configuration(metalSource: MSLDeltaE2000KernelSafe))

    func test_WithoutDifference() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))

        let difference_withTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 1.0)
        XCTAssertEqual(difference_withTollerance, 0)

        let difference_withSmallTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.00001)
        XCTAssertEqual(difference_withSmallTollerance, 0)

        let difference_withoutTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        XCTAssertEqual(difference_withoutTollerance, 0)
    }

    func test_OneDifference() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))
        
        let difference = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        XCTAssertEqual(difference, 1)
    }

    func test_TwoDifference() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))
        let difference = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        
        XCTAssertEqual(difference, 2)
    }

    func test_ThreeDifference() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))
        let difference = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        
        XCTAssertEqual(difference, 3)
    }

    func test_FullDifference() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))
        
        let difference_withSmallTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        XCTAssertEqual(difference_withSmallTollerance, 81)
        
        let difference_withBigTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 90)
        XCTAssertEqual(difference_withBigTollerance, 0)
        
        let difference_withMediumTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 20)
        XCTAssertEqual(difference_withMediumTollerance, 81)
    }

    func test_FullDifference_WithSimilarColor() throws {
        let (lhs, rhs) = images(className: String(describing: type(of: self)))
        
        let difference_withSmallTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        XCTAssertEqual(difference_withSmallTollerance, 81)
    
        let difference_withBigTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 90)
        XCTAssertEqual(difference_withBigTollerance, 0)

        let difference_withMediumTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 20)
        XCTAssertEqual(difference_withMediumTollerance, 81)
    }
    
    func test_WithoutDifference_Clear() throws {
        let (lhs, rhs) = images(testName: "test_FullDifference()", className: String(describing: type(of: self)), referenceName: "9X9_clear")

        let difference_withSmallTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 0.0)
        XCTAssertEqual(difference_withSmallTollerance, 0)

        let difference_withBigTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 90)
        XCTAssertEqual(difference_withBigTollerance, 0)

        let difference_withMediumTollerance = try kernel.difference(lhs: lhs, rhs: rhs, tollerance: 20.0)
        XCTAssertEqual(difference_withMediumTollerance, 0)
    }
}
