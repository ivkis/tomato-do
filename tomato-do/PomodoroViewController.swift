//
//  PomodoroViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import PureLayout

class PomodoroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroClock()
    }
    
    func pomodoroClock() {
        let viewClock = ClockView()

        viewClock.setTimer(value: 1500)
        viewClock.startClockTimer()

        self.view.addSubview(viewClock)

        viewClock.autoSetDimensions(to: CGSize(width: 200, height: 200))
        viewClock.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        viewClock.autoAlignAxis(toSuperviewAxis: .vertical)
    }

}
