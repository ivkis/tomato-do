//
//  MiniPomodoroCollectionView.swift
//  tomato-do
//
//  Created by IvanLazarev on 29/06/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit
import PureLayout

class MiniPomodoroCollectionView: UIView {

    @IBOutlet var containerViews: [UIView]!

    var currentPomodoro: MiniPomodoroView {
        return containerViews[State.shared.currentPomodoroIndex].subviews.last! as! MiniPomodoroView
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupMiniPomodoroCollectionView()
    }

    func setupMiniPomodoroCollectionView() {
        for view in containerViews {
            let pomodoroView = MiniPomodoroView()
            view.addSubview(pomodoroView)
            pomodoroView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))
        }
        updateFinishedPomodorosState()
    }

    func updateFinishedPomodorosState() {
        for (index, view) in containerViews.enumerated() {
            let pomodoroView = view.subviews.last! as! MiniPomodoroView
            if index < State.shared.currentPomodoroIndex {
                pomodoroView.finishAnimation()
            } else {
                pomodoroView.cleanAnimation()
            }
        }
    }
}
