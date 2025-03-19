//
//  RenderingTests.swift
//  AFSnapshotTesting
//
//  Created by Afanasy Koryakin on 23.02.2025.
//  License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

class RenderingTests: XCTestCase {
    func testShadowAndCornerRadiusRendering() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testTransparencyRendering() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)

        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testTextRendering() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "Hello, Snapshot!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center

        assertSnapshot(label, on: (size: CGSize.init(width: 200, height: 50), scale: 3))
    }

    func testTextWithShadowRendering() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.text = "Shadow Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center

        let shadow = NSShadow()
        shadow.shadowColor = UIColor.black.withAlphaComponent(0.5)
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 4

        let attributedString = NSAttributedString(
            string: "Shadow Text",
            attributes: [.shadow: shadow]
        )
        label.attributedText = attributedString

        assertSnapshot(label, on: (size: CGSize(width: 200, height: 50), scale: 3))
    }

    func testGradientRendering() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)

        view.layer.addSublayer(gradientLayer)

        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }
    
    func testAffineRendering() {
        let view = TransformableView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        assertSnapshot(view, on: (size: CGSize(width: 600, height: 600), scale: 3))
    }
}
