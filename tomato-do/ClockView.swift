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
    
    var shapeLayer = CAShapeLayer()
    var countDownTimer = Timer()
    var timerValue = 900
    var label = UILabel()

    lazy var endPlayer: AVAudioPlayer = {
        return try! AVAudioPlayer(contentsOf: R.file.endClockSoundMp3()!)
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
    
    // MARK: - Timer Preferences

    func pauseAnimation(layer: CAShapeLayer) {
        let pausedTime : CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        tickPlayer.stop()
    }

    func stopAnimation(layer: CAShapeLayer) {
        layer.removeAnimation(forKey: "ani")
        layer.speed = 1
        layer.timeOffset = 0
    }

    func resumeAnimation(layer: CAShapeLayer) {
        let pausedTime = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        tickPlayer.play()
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
        shapeLayer.lineWidth = 2

        self.layer.addSublayer(shapeLayer)
        shapeLayer.isHidden = true
    }

    private func createLabel() {
        label.textAlignment = .center
        label.font = UIFont.monospacedDigitSystemFont(ofSize: 70, weight: UIFontWeightUltraLight)
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

        shapeLayer.isHidden = false
        shapeLayer.add(animation, forKey: "ani")
    }

    private func updateLabel(value: Int) {
        setLabelText(timeFormatted(value))
        addCircle()
    }

    func setLabelText(_ value: String) {
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
        if timerValue <= 0 {
            countDownTimer.invalidate()
            tickPlayer.stop()
            endPlayer.play()
        }
    }

    func setTimer(value: Int) {
        stopAnimation(layer: shapeLayer)
        timerValue = value
        updateLabel(value: value)
    }

    func startCoundownTimer() {
        countDownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.countdown(_: )), userInfo: nil, repeats: true)
        tickPlayer.numberOfLoops = -1
        tickPlayer.play()
    }

    func startClockTimer() {
        startCoundownTimer()
        startAnimation()
    }
}
