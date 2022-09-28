//
//  SpinnerIconView.swift
//  StripeFinancialConnections
//
//  Created by Krisjanis Gaidis on 9/28/22.
//

import Foundation
import UIKit
@_spi(STP) import StripeUICore

final class SpinnerIconView: UIView {
    
    private lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.backgroundColor = .clear
        if #available(iOS 13.0, *) {
            let image = Image.spinner.makeImage()
            iconImageView.image = image
        }
        return iconImageView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.clear
        addAndPinSubview(iconImageView)

        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 40),
            heightAnchor.constraint(equalToConstant: 40),
        ])
        
        // the image will "stop rotating" on `deinit`
        startRotating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func startRotating() {
        let animationKey = "transform.rotation.z"
        let animation = CABasicAnimation(keyPath: animationKey)
        animation.toValue = NSNumber(value: .pi * 2.0)
        animation.duration = 1
        animation.repeatCount = .infinity
        animation.isCumulative = true
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        layer.add(animation, forKey: animationKey)
    }
}

#if DEBUG

import SwiftUI

@available(iOS 13.0, *)
@available(iOSApplicationExtension, unavailable)
private struct SpinnerIconViewUIViewRepresentable: UIViewRepresentable {
    
    func makeUIView(context: Context) -> SpinnerIconView {
        SpinnerIconView()
    }
    
    func updateUIView(_ uiView: SpinnerIconView, context: Context) {}
}

@available(iOSApplicationExtension, unavailable)
struct SpinnerIconView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        VStack {
            SpinnerIconViewUIViewRepresentable()
                .frame(width: 40, height: 40)
            Spacer()
        }
        .padding()
    }
}

#endif
