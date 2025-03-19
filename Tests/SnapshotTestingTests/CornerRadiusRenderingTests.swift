//
//  CornerRadiusRenderingTests.swift
//  AFSnapshotTesting
//
//  Created by Afanasy Koryakin on 23.02.2025.
//  License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import XCTest
import AFSnapshotTesting

class CornerRadiusRenderingTests: XCTestCase {
    func testBasicCornerRadius() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .blue
        view.layer.cornerRadius = 40

        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testCornerRadiusWithBorder() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .red
        view.layer.cornerRadius = 30
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor

        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testRoundedImageView() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(systemName: "person.circle.fill")  // SF Symbol как пример
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 100  // Полностью круглая картинка

        assertSnapshot(imageView, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testCustomRoundedShape() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.backgroundColor = .red

        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.topLeft, .bottomRight], cornerRadii: CGSize(width: 50, height: 50))

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        view.layer.mask = mask

        assertSnapshot(view, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }

    func testRoundedStackView() {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.cornerRadius = 20
        stackView.backgroundColor = .gray

        let label1 = UILabel()
        label1.text = "Row 1"
        label1.textAlignment = .center
        label1.backgroundColor = .white

        let label2 = UILabel()
        label2.text = "Row 2"
        label2.textAlignment = .center
        label2.backgroundColor = .white

        stackView.addArrangedSubview(label1)
        stackView.addArrangedSubview(label2)

        assertSnapshot(stackView, on: (size: CGSize(width: 200, height: 200), scale: 3))
    }
}
