//
//  MiniPomodoroView.swift
//  tomato-do
//
//  Created by IvanLazarev on 27/06/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit
import PureLayout
import AVFoundation


class MiniPomodoroView: UIView {

    var shapeLayer = CAShapeLayer()
    var timerValue = Settings.shared.pomodoroDuration

    var lineWidht: CGFloat {
        return bounds.width / 2
    }
    var lineRadius: CGFloat {
        return bounds.width / 4
    }

    override init (frame: CGRect) {
        super.init (frame: frame)
        setupMiniPomodoroView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMiniPomodoroView()
    }

    func setupMiniPomodoroView() {
        addCircle()
    }

    // MARK: - Timer management

    func stopAnimation() {
        shapeLayer.removeAnimation(forKey: "ani")
        shapeLayer.speed = 1
        shapeLayer.timeOffset = 0
        shapeLayer.isHidden = true
    }

    func finishAnimation() {
        startAnimation()
        shapeLayer.removeAnimation(forKey: "ani")
    }

    func cleanAnimation() {
        shapeLayer.isHidden = true
    }

    // MARK: - Creating animation

    func addCircle() {
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.Tomatodo.red.cgColor

        self.layer.addSublayer(shapeLayer)
        shapeLayer.isHidden = true
    }

    func startAnimation(totalDuration: TimeInterval? = nil, currentPosition: TimeInterval = 0) {
        let totalDuration = totalDuration ?? TimeInterval(timerValue)
        timerValue = Int(totalDuration - currentPosition)
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = currentPosition / totalDuration
        animation.toValue = 1
        animation.duration = CFTimeInterval(totalDuration - currentPosition)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false

        shapeLayer.isHidden = false
        shapeLayer.add(animation, forKey: "ani")
    }

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let arcCenter = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let radius = lineRadius
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: CGFloat(radius), startAngle: CGFloat(-Float.pi/2), endAngle: CGFloat(2*Float.pi-Float.pi/2), clockwise: true)

        shapeLayer.lineWidth = lineWidht
        shapeLayer.path = circlePath.cgPath
        shapeLayer.frame = layer.bounds
    }
}
