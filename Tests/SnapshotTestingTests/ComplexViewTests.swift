//
// ComplexViewTests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 11.09.2024.
// Copyright © 2024 Afanasy Koryakin. All rights reserved.
// License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

final class ComplexViewTests: XCTestCase {
    func testComplex() {
        let complex = ComplexView()
        assertSnapshot(complex, on: .iPhone14)
    }

    func testComplexSmall() {
        let complex = ComplexView()
        assertSnapshot(complex, on: (size: CGSize(width: 100, height: 300), scale: 3))
    }
    
    func testComplexMedium() {
        let complex = ComplexView()
        assertSnapshot(complex, on: (size: CGSize(width: 300, height: 300), scale: 3))
    }
    
    func testComplexBig() {
        let complex = ComplexView()
        assertSnapshot(complex, on: (size: CGSize(width: 1000, height: 1000), scale: 3))
    }
    
    func testViewFrame() {
        let complex = ComplexView(frame: .init(origin: .zero, size: .init(width: 100, height: 300)))
        assertSnapshot(complex, named: "testComplexSmall")
        
        complex.frame = .init(origin: .zero, size: .init(width: 300, height: 300))
        assertSnapshot(complex, named: "testComplexMedium")
        
        complex.frame = .init(origin: .zero, size: .init(width: 1000, height: 1000))
        assertSnapshot(complex, named: "testComplexBig")
    }
}
