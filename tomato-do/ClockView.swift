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
import AVFoundation

class ClockView: UIView {
    
    private var shapeLayer = CAShapeLayer()
    private var countDownTimer = Timer()
    private var timerValue = 900
    private var label = UILabel()

    lazy var endPlayer: AVAudioPlayer = {
        return try! AVAudioPlayer(contentsOf: R.file.clockSoundMp3()!)
    }()
    
    lazy var tickPlayer: AVAudioPlayer = {
        return try! AVAudioPlayer(contentsOf: R.file.tickingSoundMp3()!)
    }()

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
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2.5

        self.layer.addSublayer(shapeLayer)
    }
    
    private func createLabel() {
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 50, weight: UIFontWeightRegular)
        label.textColor = UIColor.white
        self.addSubview(label)
        label.autoPinEdgesToSuperviewEdges()
    }
    
    private func startAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = Double(self.timerValue)
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        shapeLayer.add(animation, forKey: "ani")
    }
    
    private func updateLabel(value: Int) {
        setLabelText(timeFormatted(value))
        addCircle()
    }
    
    private func setLabelText(_ value: String) {
        label.text = value
    }
    
    private func timeFormatted(_ totalSecond: Int) -> String {
        let seconds: Int = totalSecond % 60
        let minutes: Int = (totalSecond / 60) % 60
        
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc private func countdown(_ dt: Timer) {
        timerValue -= 1
        setLabelText(timeFormatted(timerValue))
        if timerValue == 0 {
            countDownTimer.invalidate()
            tickPlayer.stop()
            endPlayer.play()
        }
    }
    
    func setTimer(value: Int) {
        timerValue = value
        updateLabel(value: value)
    }
    
    func startClockTimer() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown(_: )), userInfo: nil, repeats: true)
        tickPlayer.play()
        tickPlayer.numberOfLoops = -1
        startAnimation()
    }    
}
