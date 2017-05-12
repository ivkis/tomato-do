//
//  PomodoroViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit

class PomodoroViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pomodoroClock()
    }
    
    func pomodoroClock() {
        let viewClock = ClockView()
        viewClock.setTimer(value: 10)
        viewClock.startClockTimer()
        self.view.addSubview(viewClock)
    }

}
