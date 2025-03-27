//
// CIEDE2000Tests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 26.03.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License
//

import Foundation
import XCTest
import CoreGraphics

//The non-safe deltaE2000 calculation function used in the kernel. Change together.
func ciede_2000(_ l1: Float, _ a1: Float, _ b1: Float, _ l2: Float, _ a2: Float, _ b2: Float) -> Float {
    let M_PI: Float = 3.14159265358979323846
    let M_PI_2: Float = 1.57079632679489661923
    
    func hypot(_ a: Float, _ b: Float) -> Float {
        return sqrt(a * a + b * b)
    }
    
    let k_l: Float = 1.0
    let k_c: Float = 1.0
    let k_h: Float = 1.0
    
    var n = (hypot(a1, b1) + hypot(a2, b2)) * 0.5
    n = n * n * n * n * n * n * n
    n = 1.0 + 0.5 * (1.0 - sqrt(n / (n + pow(25.0, 7))))
    
    let c1 = hypot(a1 * n, b1)
    let c2 = hypot(a2 * n, b2)
    
    var h1 = atan2(b1, a1 * n)
    var h2 = atan2(b2, a2 * n)
    
    h1 += (h1 < 0.0) ? 2.0 * M_PI : 0.0
    h2 += (h2 < 0.0) ? 2.0 * M_PI : 0.0
    
    var delta_h = abs(h2 - h1)
    delta_h = (delta_h > M_PI - 1e-14 && delta_h < M_PI + 1e-14) ? M_PI : delta_h

    var h_m = 0.5 * h1 + 0.5 * h2
    var h_d = (h2 - h1) * 0.5

    let should_adjust: Float = delta_h > M_PI ? 1.0 : 0.0
    let h_d_sign: Float = h_d > 0.0 ? -1.0 : 1.0

    h_d += should_adjust * h_d_sign * M_PI
    h_m += should_adjust * M_PI

    let c_avg = (c1 + c2) * 0.5
    let c_avg_pow7 = pow(c_avg, 7)

    let p = (36.0 * h_m - 55.0 * M_PI)
    let r_t = -2.0 * sqrt(c_avg_pow7 / (c_avg_pow7 + pow(25.0, 7))) *
              sin(M_PI / 3.0 * exp(p * p / (-25.0 * M_PI * M_PI)))
    
    let l_avg = (l1 + l2) * 0.5
    let l_diff = (l2 - l1) / (k_l * (1.0 + 0.015 * pow(l_avg - 50.0, 2) / sqrt(20.0 + pow(l_avg - 50.0, 2))))

    let t = 1.0 +
            0.24 * sin(2.0 * h_m + M_PI_2) +
            0.32 * sin(3.0 * h_m + 8.0 * M_PI / 15.0) -
            0.17 * sin(h_m + M_PI / 3.0) -
            0.20 * sin(4.0 * h_m + 3.0 * M_PI_2 / 10.0)

    let h_diff = 2.0 * sqrt(c1 * c2) * sin(h_d) / (k_h * (1.0 + 0.0075 * (c1 + c2) * t))
    let c_diff = (c2 - c1) / (k_c * (1.0 + 0.0225 * (c1 + c2)))

    return sqrt(pow(l_diff, 2) + pow(c_diff, 2) + pow(h_diff, 2) + c_diff * h_diff * r_t)
}

class CIEDE2000Tests: XCTestCase {
    func ciede2000(l1: Float, a1: Float, b1: Float, l2: Float, a2: Float, b2: Float) -> Float {
        return ciede_2000(l1, a1, b1, l2, a2, b2)
    }
    
    func testIdenticalColors() {
        let deltaE = ciede2000(l1: 50, a1: 0, b1: 0, l2: 50, a2: 0, b2: 0)
        XCTAssertEqual(deltaE, 0, "Identical colors should have ΔE = 0")
    }

    //From CIEDE2000 standart
    func testKnownColorDifference1() {
        let deltaE = ciede2000(l1: 50, a1: 2.6772, b1: -79.7751,
                               l2: 50, a2: 0, b2: -82.7485)
        XCTAssertEqual(deltaE, 2.0425, accuracy: 0.0001)
    }
    
    //From CIEDE2000 standart
    func testKnownColorDifference2() {
        let deltaE = ciede2000(l1: 50, a1: 3.1571, b1: -77.2803,
                               l2: 50, a2: 0, b2: -82.7485)
        XCTAssertEqual(deltaE, 2.8615, accuracy: 0.0001)
    }
    
    func testExtremeDifference() {
        let deltaE = ciede2000(l1: 0, a1: 0, b1: 0,
                               l2: 100, a2: 127, b2: 127)
        XCTAssertGreaterThan(deltaE, 100, "Extremely different colors should have large ΔE")
    }
    
    func testHueQuadrantTransition() {
        let delta1 = ciede2000(l1: 50, a1: 10, b1: 10,
                               l2: 50, a2: -10, b2: 10)
        let delta2 = ciede2000(l1: 50, a1: 10, b1: 10,
                               l2: 50, a2: -10, b2: -10)
        XCTAssertNotEqual(delta1, delta2, "Different quadrant transitions should produce different ΔE")
    }
    
    func testColorDifferencesWithFloatPrecision() {
        var deltaE = ciede2000(l1: 58.18, a1: 77.92, b1: -17.7,
                              l2: 58.18, a2: 77.86, b2: -17.7)
        XCTAssertEqual(deltaE, 0.0136, accuracy: 0.0005, "Test case 1 failed")
        
        deltaE = ciede2000(l1: 58.0931, a1: -15.461, b1: 109.0,
                          l2: 58.0931, a2: -15.461, b2: 110.782)
        XCTAssertEqual(deltaE, 0.3161, accuracy: 0.001, "Test case 2 failed")
        
        deltaE = ciede2000(l1: 96.747, a1: 60.386, b1: -109.18,
                          l2: 96.747, a2: 59.5, b2: -106.76)
        XCTAssertEqual(deltaE, 0.5186, accuracy: 0.001, "Test case 3 failed")
        
        deltaE = ciede2000(l1: 72.1, a1: 90.7238, b1: -94.158,
                          l2: 72.1, a2: 90.7238, b2: -87.79)
        XCTAssertEqual(deltaE, 1.8870, accuracy: 0.005, "Test case 4 failed")
        
        deltaE = ciede2000(l1: 59.981, a1: -70.0, b1: -88.902,
                          l2: 62.8, a2: -70.0, b2: -96.92)
        XCTAssertEqual(deltaE, 2.9103, accuracy: 0.01, "Test case 5 failed")
        
        deltaE = ciede2000(l1: 89.0, a1: -27.068, b1: -122.0,
                          l2: 94.39, a2: -27.068, b2: -122.0)
        XCTAssertEqual(deltaE, 3.3233, accuracy: 0.01, "Test case 6 failed")
        
        deltaE = ciede2000(l1: 18.67, a1: 4.8, b1: -88.4,
                          l2: 18.67, a2: 12.48, b2: -88.4)
        XCTAssertEqual(deltaE, 4.2486, accuracy: 0.01, "Test case 7 failed")
        
        deltaE = ciede2000(l1: 83.2491, a1: -23.4, b1: 28.0,
                          l2: 88.37, a2: -23.4, b2: 22.0)
        XCTAssertEqual(deltaE, 4.4798, accuracy: 0.01, "Test case 8 failed")

        deltaE = ciede2000(l1: 53.4379, a1: 124.735, b1: -3.0,
                          l2: 50.0, a2: 61.0134, b2: -4.0)
        XCTAssertEqual(deltaE, 12.8009, accuracy: 0.05, "Test case 9 failed")
        
        deltaE = ciede2000(l1: 52.4679, a1: 91.46, b1: 116.402,
                          l2: 49.1, a2: 96.537, b2: 75.95)
        XCTAssertEqual(deltaE, 14.3417, accuracy: 0.1, "Test case 10 failed")
    }
}
