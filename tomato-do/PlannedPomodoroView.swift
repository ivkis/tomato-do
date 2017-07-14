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
        var currentView: UIImageView?
        for _ in 0..<task.plannedPomodoro {
            let exampleView = UIImageView(image: R.image.plannedBackground())
            self.addSubview(exampleView)
            exampleView.autoPinEdge(toSuperviewEdge: .top)
            exampleView.autoPinEdge(toSuperviewEdge: .bottom)
            exampleView.autoMatch(.width, to: .height, of: exampleView)
            if let currentView = currentView {
                exampleView.autoPinEdge(.leading, to: .trailing, of: currentView, withOffset: 2)
            } else {
                exampleView.autoPinEdge(toSuperviewEdge: .leading)
            }
            currentView = exampleView
        }
    }
}
