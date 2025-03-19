//
// CustomShapeImageViewTests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 16.02.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

class CustomShapeImageViewTests: XCTestCase {
    func testCircularImageView() {
        let imageView = createCustomShapeImageView(path: UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 200, height: 200)))
        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "CircularImageView")
    }

    func testTriangleImageViewWithTransparency() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 100, y: 0))
        path.addLine(to: CGPoint(x: 200, y: 200))
        path.addLine(to: CGPoint(x: 0, y: 200))
        path.close()

        let imageView = createCustomShapeImageView(path: path, alpha: 0.5)
        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "TriangleImageViewWithTransparency")
    }

    func testStarImageViewWithTransparencyAndShadow() {
        let path = createStarPath()

        let imageView = createCustomShapeImageView(path: path, alpha: 0.5)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "StarImageViewWithTransparencyAndShadow")
    }

    func testOvalImageViewWithGradient() {
        let path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 200, height: 120))
        let imageView = createCustomShapeImageView(path: path)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        imageView.layer.insertSublayer(gradientLayer, at: 0)

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 120), scale: 3), named: "OvalImageViewWithGradient")
    }

    func testComplexShapeMixingAllEffects() {
        let path = createStarPath()
        let imageView = createCustomShapeImageView(path: path, alpha: 0.5)

        // Градиент
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [UIColor.green.cgColor, UIColor.yellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        imageView.layer.insertSublayer(gradientLayer, at: 0)

        // Тень
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 5
        imageView.layer.shadowOffset = CGSize(width: 3, height: 3)

        // Полупрозрачная граница
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "ComplexShapeMixingAllEffects")
    }

    // MARK: Helpers

    private func createCustomShapeImageView(path: UIBezierPath, alpha: CGFloat = 1.0) -> UIImageView {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.systemTeal.cgColor

        let imageView = UIImageView(frame: path.bounds)
        imageView.layer.mask = shapeLayer
        imageView.alpha = alpha

        return imageView
    }

    private func createStarPath() -> UIBezierPath {
        let path = UIBezierPath()
        let starPoints: [CGPoint] = [
            CGPoint(x: 100, y: 0),
            CGPoint(x: 120, y: 70),
            CGPoint(x: 200, y: 70),
            CGPoint(x: 130, y: 110),
            CGPoint(x: 160, y: 180),
            CGPoint(x: 100, y: 140),
            CGPoint(x: 40, y: 180),
            CGPoint(x: 70, y: 110),
            CGPoint(x: 0, y: 70),
            CGPoint(x: 80, y: 70)
        ]

        path.move(to: starPoints[0])
        for point in starPoints.dropFirst() {
            path.addLine(to: point)
        }
        path.close()
        
        return path
    }
}
