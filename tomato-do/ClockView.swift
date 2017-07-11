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


protocol ClockViewDelegate: class {
    func clockViewDidEndTimer(_ clockView: ClockView)
}


class ClockView: MiniPomodoroView {

    weak var delegate: ClockViewDelegate?

    var countDownTimer = Timer()
    var label = UILabel()

    lazy var endPlayer: AVAudioPlayer = {
        return try? AVAudioPlayer(contentsOf: R.file.endClockSoundMp3()!)
        }()!

    lazy var tickPlayer: AVAudioPlayer = {
        return try? AVAudioPlayer(contentsOf: R.file.tickingSoundMp3()!)
        }()!

    override var lineWidht: CGFloat {
        return 2
    }

    override var lineRadius: CGFloat {
        return bounds.width / 2
    }

    override init (frame: CGRect) {
        super.init (frame: frame)
        self.createLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.createLabel()
    }

    deinit {
        countDownTimer.invalidate()
    }

    override func addCircle() {
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidht

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

    private func updateLabel(value: Int) {
        setLabelText(timeFormatted(value))
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
            delegate?.clockViewDidEndTimer(self)
        }
    }

    func setTimer(value: Int) {
        stopAnimation()
        timerValue = value
        updateLabel(value: value)
    }

    func startCoundownTimer() {
        countDownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            self?.countdown(timer)
        }
        tickPlayer.numberOfLoops = -1
        if Settings.shared.tickSoundStatus {
            tickPlayer.play()
        }
    }

    func stopClockTimer() {
        stopAnimation()
        countDownTimer.invalidate()
        tickPlayer.stop()
    }

    func startClockTimer() {
        startCoundownTimer()
        startAnimation()
    }
}
