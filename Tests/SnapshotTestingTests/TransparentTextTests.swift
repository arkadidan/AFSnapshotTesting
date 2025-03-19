//
// TransparentTextTests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 16.02.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

class TransparentTextTests: XCTestCase {
    let traits = [UITraitCollection(legibilityWeight: .bold)]

    func testTransparentTextLabel() {
        let label = createTransparentLabel(text: "Hello, World!", alpha: 0.5)
        assertSnapshot(label, on: (size: CGSize(width: 300, height: 100), scale: 3), named: "TransparentTextLabel")
        assertSnapshot(label, on: (size: CGSize(width: 300, height: 100), scale: 3), traits: traits, named: "TransparentTextLabelBold")
    }

    func testTextWithDifferentTransparencyLevels() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 900, height: 100))
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        let lowAlpha = createTransparentLabel(text: "Low Alpha", alpha: 0.1)
        let mediumAlpha = createTransparentLabel(text: "Medium Alpha", alpha: 0.5)
        let highAlpha = createTransparentLabel(text: "High Alpha", alpha: 0.9)

        stackView.addArrangedSubview(lowAlpha)
        stackView.addArrangedSubview(mediumAlpha)
        stackView.addArrangedSubview(highAlpha)
        
        let size = (size: CGSize(width: 900, height: 100), scale: 3)
        assertSnapshot(stackView, on: size, named: "TextWithDifferentTransparencyLevels")
        assertSnapshot(stackView, on: size, traits: traits, named: "TextWithDifferentTransparencyLevelsTraitsBold")
    }

    func testTransparentTextWithBackground() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        backgroundView.backgroundColor = .blue

        let label = createTransparentLabel(text: "Transparent Text", alpha: 0.5)
        label.center = backgroundView.center
        backgroundView.addSubview(label)

        let size = (size: CGSize(width: 300, height: 100), scale: 3)
        assertSnapshot(backgroundView, on: size, named: "TransparentTextWithBackground")
        assertSnapshot(backgroundView, on: size, traits: traits, named: "TransparentTextWithBackgroundTraitsBold")
    }

    func testTransparentTextWithShadow() {
        let label = createTransparentLabel(text: "Shadow Text", alpha: 0.5)
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowOpacity = 0.5
        label.layer.shadowRadius = 3
        label.layer.shadowOffset = CGSize(width: 2, height: 2)

        let size = (size: CGSize(width: 300, height: 100), scale: 3)
        assertSnapshot(label, on: size, named: "TransparentTextWithShadow")
        assertSnapshot(label, on: size, traits: traits, named: "TransparentTextWithShadowTraitsBold")
    }

    func testTransparentTextWithGradientMask() {
        let label = createTransparentLabel(text: "Gradient Mask", alpha: 1.0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = label.bounds
        gradientLayer.colors = [UIColor.black.cgColor, UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        let maskLayer = CALayer()
        maskLayer.frame = label.bounds
        maskLayer.addSublayer(gradientLayer)

        label.layer.mask = maskLayer

        let size = (size: CGSize(width: 300, height: 100), scale: 3)
        assertSnapshot(label, on: size, named: "TransparentTextWithGradientMask")
        assertSnapshot(label, on: size, traits: traits, named: "TransparentTextWithGradientMaskTraitsBold")
    }

    // MARK: - Helper

    private func createTransparentLabel(text: String, alpha: CGFloat) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
        label.text = text
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textAlignment = .center
        label.alpha = alpha
        return label
    }
}
