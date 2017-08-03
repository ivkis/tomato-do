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
    fileprivate(set) var plannedCount: Int = 0
    fileprivate(set) var finishedPomodorosCount: Int = 0

    func configure(plannedCount: Int, finishedCount: Int, animatedIndex: Int, currentTime: TimeInterval, totalDuration: TimeInterval) {
        self.plannedCount = plannedCount
        self.finishedPomodorosCount = finishedCount
        createContainerViews(count: max(plannedCount, finishedCount, animatedIndex + 1))
        updateFinishedPomodorosState()
        animatePomodoro(at: animatedIndex, currentTime: currentTime, totalDuration: totalDuration)
    }

    func configure(plannedCount: Int, finishedCount: Int) {
        self.plannedCount = plannedCount
        self.finishedPomodorosCount = finishedCount
        createContainerViews(count: max(plannedCount, finishedCount))
        updateFinishedPomodorosState()
    }

    fileprivate func animatePomodoro(at index: Int, currentTime: TimeInterval, totalDuration: TimeInterval) {
        let pomodoroView = containerViews[index].subviews.last! as? MiniPomodoroView
        pomodoroView?.startAnimation(totalDuration: totalDuration, currentPosition: currentTime)
    }

    fileprivate func updateFinishedPomodorosState() {
        for (index, view) in containerViews.enumerated() {
            let pomodoroView = view.subviews.last! as! MiniPomodoroView
            if index < finishedPomodorosCount {
                pomodoroView.finishAnimation()
            } else {
                pomodoroView.cleanAnimation()
            }
        }
    }

    fileprivate func createContainerViews(count: Int) {
        subviews.forEach({ $0.removeFromSuperview() })
        containerViews = []
        var stackView: UIStackView!
        let rowCount = Constants.maximumPomodorosOfRow
        let fRowCount = CGFloat(rowCount)
        for i in 0..<count {
            if i % rowCount == 0 {
                let previousStackView = stackView
                stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
                stackView.alignment = .center
                stackView.spacing = floor((UIScreen.main.bounds.width - fRowCount * R.image.miniBackground()!.size.width) / (fRowCount + 1))
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
            imageView.autoSetDimensions(to: imageView.image!.size)
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
