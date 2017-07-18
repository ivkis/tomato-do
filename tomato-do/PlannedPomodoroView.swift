//
//  PlannedPomodoroView.swift
//  tomato-do
//
//  Created by IvanLazarev on 14/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit


class PlannedPomodoroView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with task: Task) {
        subviews.forEach({ $0.removeFromSuperview() })
        var currentView: UIImageView?

        for i in 0..<task.plannedPomodoro {
            let image = i < task.completedPomodoro ? R.image.completedPomodoro() : R.image.miniBackground()
            let plannedPomodoroView = UIImageView(image: image)
            self.addSubview(plannedPomodoroView)
            plannedPomodoroView.autoPinEdge(toSuperviewEdge: .top)
            plannedPomodoroView.autoPinEdge(toSuperviewEdge: .bottom)
            plannedPomodoroView.autoMatch(.width, to: .height, of: plannedPomodoroView)
            if let currentView = currentView {
                plannedPomodoroView.autoPinEdge(.leading, to: .trailing, of: currentView, withOffset: 2)
            } else {
                plannedPomodoroView.autoPinEdge(toSuperviewEdge: .leading)
            }
            currentView = plannedPomodoroView
        }
    }
}
