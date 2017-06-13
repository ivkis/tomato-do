//
//  PomodoroViewController.swift
//  tomato-do
//
//  Created by IvanLazarev on 11/05/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit
import PureLayout

class PomodoroViewController: UIViewController, UITextFieldDelegate {

    let viewClock = ClockView()

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var UnexpectedTaskTextField: UITextField!

    @IBAction func backToDoPress(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func startButtonPress(_ sender: Any) {
        viewClock.startClockTimer()

        startButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func pauseButtonPress(_ sender: Any) {
        viewClock.pauseAnimation(layer: viewClock.shapeLayer)
        viewClock.countDownTimer.invalidate()

        pauseButton.isHidden = true
        stopButton.isHidden = false
        resumeButton.isHidden = false
    }

    @IBAction func resumeButtonPress(_ sender: Any) {
        viewClock.startCoundownTimer()
        viewClock.resumeAnimation(layer: viewClock.shapeLayer)

        resumeButton.isHidden = true
        stopButton.isHidden = true
        pauseButton.isHidden = false
    }

    @IBAction func stopButtonPress(_ sender: Any) {
        let noAlertAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        let yesAlertAction = UIAlertAction(title: "Yes", style: .destructive) { action in
            self.pomodoroClock()

            self.stopButton.isHidden = true
            self.resumeButton.isHidden = true
            self.startButton.isHidden = false
        }
        let alertController = UIAlertController(title: "Stop Timer", message: "Are you sure you want to stop the curent pomodoro?", preferredStyle: .alert)
        alertController.addAction(noAlertAction)
        alertController.addAction(yesAlertAction)
        self.present(alertController, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPomodoroViewController()
        pomodoroClock()
        UnexpectedTaskTextField.delegate = self

        pauseButton.isHidden = true
        stopButton.isHidden = true
        resumeButton.isHidden = true
    }

    func setupPomodoroViewController() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9354019761, green: 0.3499509096, blue: 0.1937675774, alpha: 1)
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.tintColor = UIColor.white
    }

    func pomodoroClock() {
        viewClock.setTimer(value: 30)

        self.view.addSubview(viewClock)

        viewClock.autoSetDimensions(to: CGSize(width: 250, height: 250))
        viewClock.autoPinEdge(toSuperviewEdge: .top, withInset: 105)
        viewClock.autoAlignAxis(toSuperviewAxis: .vertical)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UnexpectedTaskTextField.resignFirstResponder()
        CoreDataManager.shared.addTask(taskToDo: (textField.text)!)
        UnexpectedTaskTextField.text = ""

        return true
    }
}
