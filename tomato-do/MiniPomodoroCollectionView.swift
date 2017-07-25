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

    var containerViews = [UIView]()

    var currentPomodoro: MiniPomodoroView? {
        guard State.shared.currentPomodoroIndex < containerViews.count else {
            return nil
        }
        return containerViews[State.shared.currentPomodoroIndex].subviews.last! as? MiniPomodoroView
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMiniPomodoroCollectionView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupMiniPomodoroCollectionView()
    }

    func setupMiniPomodoroCollectionView() {
        createContainerViews()
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

    func createContainerViews() {
        var stackView: UIStackView!
        let count = 7
        let fcount = CGFloat(count)
        for i in 0..<Settings.shared.targetPomodoros {
            if i % count == 0 {
                let previousStackView = stackView
                stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
                stackView.alignment = .center
                stackView.spacing = floor((UIScreen.main.bounds.width - fcount * R.image.miniBackground()!.size.width) / (fcount + 1))
                addSubview(stackView)

                if let previousStackView = previousStackView {
                    stackView.autoPinEdge(.top, to: .bottom, of: previousStackView, withOffset: 10)
                } else {
                    stackView.autoPinEdge(.top, to: .top, of: self, withOffset: 15)
                }
                stackView.autoAlignAxis(toSuperviewAxis: .vertical)
            }
            let containerView = UIView()
            let imageView = UIImageView(image: R.image.miniBackground())
            containerView.addSubview(imageView)
            imageView.autoPinEdgesToSuperviewEdges()
            stackView.addArrangedSubview(containerView)
            containerViews.append(containerView)
        }
        if let lastSteckView = stackView {
            lastSteckView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -15)
        }
    }

}
