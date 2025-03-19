//
// TransformableView.swift
// AFSnapshotTesting
//
// Created by Afanasy Koryakin on 18.02.2025.
// Copyright © 2025 Afanasy Koryakin. All rights reserved.
// License: MIT License, https://github.com/afanasykoryakin/AFSnapshotTesting/blob/master/LICENSE
//

import UIKit

class TransformableView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIcons()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupIcons()
    }
    
    private func setupIcons() {
        let icons: [UIImage] = [
            UIImage(systemName: "star.fill")!,
            UIImage(systemName: "heart.fill")!,
            UIImage(systemName: "circle.fill")!
        ]
        
        for i in 0..<icons.count {
            let imageView = UIImageView(image: icons[i])
            imageView.tintColor = [.red, .blue, .green][i]
            imageView.frame = CGRect(x: 50 + i * 100, y: 50 + i * 100, width: 80, height: 80)

            let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
            let rotation = CGAffineTransform(rotationAngle: .pi / 6 * CGFloat(i + 1))
            let translation = CGAffineTransform(translationX: CGFloat(30 * i), y: CGFloat(20 * i))
            
            imageView.transform = scale.concatenating(rotation).concatenating(translation)
            
            addSubview(imageView)
        }
    }
}
