//
//  PomodoroCountPickerView.swift
//  tomato-do
//
//  Created by IvanLazarev on 14/07/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import Foundation
import UIKit


class PomodoroCountPickerView: UIView {
    fileprivate var buttons = [UIButton]()

    var value: Int = 1 {
        didSet {
            refreshUI()
        }
    }

    override init(frame: CGRect) {
        var frame = frame
        frame.size.height = 30
        super .init(frame: frame)
        setupCountPickerView()
    }

    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        setupCountPickerView()
    }

    func setupCountPickerView() {
        let count = 10
        backgroundColor = UIColor.Tomatodo.darkBlue
        for i in 0..<count {
            let button = UIButton()
            button.setImage(R.image.plannedPomodoro(), for: .normal)
            button.setImage(R.image.plannedPomodoroSelected(), for: .selected)
            button.tag = i
            buttons.append(button)
            button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: .touchUpInside)

            self.addSubview(button)

            let multiplier = (1 + 2 * CGFloat(i)) / CGFloat(count)
            button.autoAlignAxis(.vertical, toSameAxisOf: self, withMultiplier: multiplier)
            button.autoPinEdge(toSuperviewEdge: .top)
            button.autoPinEdge(toSuperviewEdge: .bottom)
        }
        refreshUI()
    }

    func buttonTapped(_ sender: UIButton) {
        value = sender.tag + 1
    }

    fileprivate func refreshUI() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = index < value
        }
    }
}
