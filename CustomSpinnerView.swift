//
//  CustomSpinnerView.swift
//  CoreUIKit
//
//  Created by Edwin Wilson on 3/28/19.
//  Copyright © 2019 Altayer. All rights reserved.
//
//  Save to the extent permitted by law, you may not use, copy, modify,
//  distribute or create derivative works of this material or any part
//  of it without the prior written consent of Altayer.
//  Any reproduction of this material must contain this notice.
//

import UIKit

public class CustomSpinnerView: UIView {

    private enum Constants {

        static let animationDuration = 5.0 // Total animation duration
        static let spinnerPerimeterPercentage = 0.85
        static let keyAnimationPhase = 10.0 // Total animations in given duartion
    }

    private let spinnerLayer = CAShapeLayer()
    private var spinnerFrameSize: CGSize?
    private var keyTime: [Double] = [0.0]
    private var rotationValues: [Double] = [0.0]

    override public func layoutSubviews() {

        super.layoutSubviews()

        spinnerLayer.frame = bounds
        spinnerLayer.fillColor =  nil
        spinnerLayer.strokeColor = UIColor.black.cgColor
        spinnerLayer.lineWidth = 3
        setPath()
        layer.addSublayer(spinnerLayer)
    }

    override public func didMoveToWindow() {

        super.didMoveToWindow()
        animateSpinner()
    }

    private func setPath() {
        spinnerLayer.path = UIBezierPath(
            ovalIn: bounds.insetBy(
                dx: spinnerLayer.lineWidth / 2,
                dy: spinnerLayer.lineWidth / 2
            )
        ).cgPath
    }

    private func animateSpinner() {

        generateKeyTimesAndRotationValues()
        animateStroke()
        animateRotation()
    }

    private func animateStroke() {

        let animation = CAKeyframeAnimation(keyPath: "strokeEnd")
        var stokeLengthValues = keyTime
        stokeLengthValues.append(0.0)
        animation.calculationMode = .paced
        animateKeypath(fameAnimation: animation, values: stokeLengthValues)
    }

    private func animateRotation() {

        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        animation.calculationMode = .linear
        animateKeypath(fameAnimation: animation, values: rotationValues)
    }

    private func animateKeypath(
        fameAnimation: CAKeyframeAnimation,
        values: [Double]
        ) {

        fameAnimation.keyTimes = keyTime as [NSNumber]?
        fameAnimation.values = values as [NSNumber]?
        fameAnimation.calculationMode = .linear
        fameAnimation.duration = Constants.animationDuration
        fameAnimation.repeatCount = Float.infinity
        spinnerLayer.add(fameAnimation, forKey: fameAnimation.keyPath)
    }

    private func generateKeyTimesAndRotationValues() {

        for i in 1...10 {
            let baseTime = Double(i)/10.0
            keyTime.append(baseTime)
            let nextRotationValue = (rotationValues.last ?? 0.0) + .pi
            rotationValues.append(nextRotationValue)
        }

        //animation to orginal state
        if let lastKeyValue = keyTime.last {
            keyTime.append(lastKeyValue)
        }
        if let firstRotaionValue = rotationValues.first {
            rotationValues.append(firstRotaionValue)
        }
    }
}
