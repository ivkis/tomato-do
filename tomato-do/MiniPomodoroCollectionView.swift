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

    fileprivate var containerViews = [UIView]()

    var planedCount: Int = 0 {
        didSet {
            createContainerViews()
        }
    }

    var finishedPomodorosCount: Int = 0 {
        didSet {
            updateFinishedPomodorosState()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createContainerViews()
        updateFinishedPomodorosState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createContainerViews()
        updateFinishedPomodorosState()
    }

    func animatePomodoro(at index: Int, currentTime: TimeInterval, totalDuration: TimeInterval) {
        let pomodoroView = containerViews[index].subviews.last! as? MiniPomodoroView
        pomodoroView?.startAnimation(totalDuration: totalDuration, currentPosition: currentTime)
    }

    func updateFinishedPomodorosState() {
        for (index, view) in containerViews.enumerated() {
            let pomodoroView = view.subviews.last! as! MiniPomodoroView
            if index < finishedPomodorosCount {
                pomodoroView.finishAnimation()
            } else {
                pomodoroView.cleanAnimation()
            }
        }
    }

    func createContainerViews() {
        subviews.forEach({ $0.removeFromSuperview() })
        containerViews = []
        var stackView: UIStackView!
        let count = 7
        let fcount = CGFloat(count)
        for i in 0..<planedCount {
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

            let pomodoroView = MiniPomodoroView()
            containerView.addSubview(pomodoroView)
            pomodoroView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2))

            stackView.addArrangedSubview(containerView)
            containerViews.append(containerView)
        }
        if let lastSteckView = stackView {
            lastSteckView.autoPinEdge(.bottom, to: .bottom, of: self, withOffset: -15)
        }
    }

}
