//
//  ClockView.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class ClockView: UIView {
    
    private var shapeLayer = CAShapeLayer()
    private var countDownTimer = Timer()
    private var timerValue = 900
    private var label = UILabel()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        self.createLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        let arcCenter = CGPoint(x: self.bounds.width/2, y: self.bounds.height/2)
        let radius = self.bounds.width/2
        let circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat(-Float.pi/2), endAngle: CGFloat(2*Float.pi-Float.pi/2), clockwise: true)
        shapeLayer.path = circlePath.cgPath

        shapeLayer.frame = layer.bounds
    }
    
    private func addCircle() {
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.white.cgColor
        self.shapeLayer.lineWidth = 2.5

        self.layer.addSublayer(self.shapeLayer)
    }
    
    private func createLabel() {
        label.textAlignment = .center
        self.label.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: UIFontWeightRegular)
        self.label.textColor = UIColor.white
        self.addSubview(self.label)
        self.label.autoPinEdgesToSuperviewEdges()
    }
    
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(self.timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        self.shapeLayer.add(animation, forKey: "ani")
    }
    
    private func updateLabel(value: Int) {
        self.setLabelText(self.timeFormatted(value))
        self.addCircle()
    }
    
    private func setLabelText(_ value: String) {
        self.label.text = value
    }
    
    private func timeFormatted(_ totalSecond: Int) -> String {
        let seconds: Int = totalSecond % 60
        let minutes: Int = (totalSecond / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func countdown(_ dt: Timer) {
        self.timerValue -= 1
        if self.timerValue < 0 {
            self.countDownTimer.invalidate()
        }
        else {
            self.setLabelText(self.timeFormatted(self.timerValue))
        }
    }
    
    func setTimer(value: Int) {
        self.timerValue = value
        self.updateLabel(value: value)
    }
    
    func startClockTimer() {
        self.countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown(_: )), userInfo: nil, repeats: true)
        self.startAnimation()
    }    
}
