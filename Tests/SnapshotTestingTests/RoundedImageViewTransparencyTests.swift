//
// RoundedImageViewTransparencyTests.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 16.02.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

class RoundedImageViewTransparencyTests: XCTestCase {
    /// 📌 Прозрачность (alpha = 0.5)
    func testRoundedImageViewWithTransparency() {
        let imageView = createRoundedImageView(alpha: 0.5)
        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "RoundedImageViewWithTransparency")
    }

    /// 📌 Разные уровни прозрачности
    func testRoundedImageViewWithDifferentTransparencyLevels() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 600, height: 200))
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        let lowAlpha = createRoundedImageView(alpha: 0.1)
        let mediumAlpha = createRoundedImageView(alpha: 0.5)
        let highAlpha = createRoundedImageView(alpha: 0.9)

        stackView.addArrangedSubview(lowAlpha)
        stackView.addArrangedSubview(mediumAlpha)
        stackView.addArrangedSubview(highAlpha)

        assertSnapshot(stackView, on: (size: CGSize(width: 600, height: 200), scale: 3), named: "RoundedImageViewWithDifferentTransparencyLevels")
    }

    /// 📌 Прозрачность + фон
    func testRoundedImageViewWithBackground() {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        backgroundView.backgroundColor = .blue

        let imageView = createRoundedImageView(alpha: 0.5)
        imageView.center = backgroundView.center
        backgroundView.addSubview(imageView)

        assertSnapshot(backgroundView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "RoundedImageViewWithBackground")
    }

    /// 📌 Полупрозрачная граница
    func testRoundedImageViewWithTransparentBorder() {
        let imageView = createRoundedImageView(alpha: 1.0)
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.5).cgColor

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "RoundedImageViewWithTransparentBorder")
    }

    /// 📌 Прозрачность + тень
    func testRoundedImageViewWithTransparencyAndShadow() {
        let imageView = createRoundedImageView(alpha: 0.5)
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.shadowRadius = 10
        imageView.layer.shadowOffset = CGSize(width: 5, height: 5)

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "RoundedImageViewWithTransparencyAndShadow")
    }

    /// 📌 Градиентная прозрачность (сверху прозрачный, снизу — непрозрачный)
    func testRoundedImageViewWithGradientMask() {
        let imageView = createRoundedImageView(alpha: 1.0)

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = imageView.bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)

        let maskLayer = CALayer()
        maskLayer.frame = imageView.bounds
        maskLayer.addSublayer(gradientLayer)

        imageView.layer.mask = maskLayer

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3), named: "RoundedImageViewWithGradientMask")
    }

    /// 📌 Несколько прозрачных `UIImageView` в `UIStackView`
    func testMultipleRoundedImageViewsWithTransparency() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 600, height: 200))
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually

        let image1 = createRoundedImageView(alpha: 0.2)
        let image2 = createRoundedImageView(alpha: 0.5)
        let image3 = createRoundedImageView(alpha: 0.8)

        stackView.addArrangedSubview(image1)
        stackView.addArrangedSubview(image2)
        stackView.addArrangedSubview(image3)

        assertSnapshot(stackView, on: (size: CGSize(width: 600, height: 200), scale: 3), named: "MultipleRoundedImageViewsWithTransparency")
    }

    // MARK: - Helper

    private func createRoundedImageView(alpha: CGFloat) -> UIImageView {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(systemName: "person.circle.fill")  // SF Symbol как пример
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.alpha = alpha
        return imageView
    }
}
