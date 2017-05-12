//
//  ClockView.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit

class ClockView: UIView {
    
    private var shapeLayer = CAShapeLayer()
    private var countDownTimer = Timer()
    private var timerValue = 900
    private var label = UILabel()
    
    override init (frame: CGRect) {
        super.init (frame: frame)
        self.createLable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func addCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 205, y: 200), radius: CGFloat(100), startAngle: CGFloat(-Float.pi/2), endAngle: CGFloat(2*Float.pi-Float.pi/2), clockwise: true)
        
        self.shapeLayer.path = circlePath.cgPath
        self.shapeLayer.fillColor = UIColor.clear.cgColor
        self.shapeLayer.strokeColor = UIColor.white.cgColor
        self.shapeLayer.lineWidth = 2.5
        
        self.layer.addSublayer(self.shapeLayer)
    }
    
    private func createLable() {
        self.label = UILabel(frame: CGRect(x: 138, y: 147, width: 200, height: 100))
        self.label.font = UIFont(name: self.label.font.fontName, size: 50)
        self.label.textColor = UIColor.white
        
        self.addSubview(self.label)
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
