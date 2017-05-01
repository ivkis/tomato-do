//
//  MainScreenViewController.swift
//  tomato-do
//
//  Created by Иван Лазарев on 25/04/2017.
//  Copyright © 2017 Иван Лазарев. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {

    @IBOutlet weak var addTaskButton: UIButton!
    @IBAction func addTaskButtonTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainScreenViewController()
    }
    
    func setupMainScreenViewController() {
        addTaskButton.layer.cornerRadius = 2
    }
}

