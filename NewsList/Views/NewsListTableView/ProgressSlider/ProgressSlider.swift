//
//  ProgressSlider.swift
//  NewsList
//
//  Created by Maxim Osyagin on 27.06.2021.
//

import UIKit

class ProgressSlider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setThumbImage(UIImage(), for: .normal)
        isContinuous = true
        maximumTrackTintColor = .lightGray
        minimumTrackTintColor = .darkGray
        isUserInteractionEnabled = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let trackRect = super.trackRect(forBounds: bounds)
        let newHeight: CGFloat = 2
        let yOffset = (trackRect.size.height - newHeight) / 2
        return CGRect(
            x: trackRect.origin.x,
            y: trackRect.origin.y + yOffset,
            width: trackRect.size.width,
            height: newHeight
        )
    }

    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        let thumbRect = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        let newSize: CGFloat = 0
        let yOffset = (thumbRect.size.height - newSize) / 2
        return CGRect(
            x: thumbRect.origin.x,
            y: thumbRect.origin.y + yOffset,
            width: newSize,
            height: newSize
        )
    }
}
