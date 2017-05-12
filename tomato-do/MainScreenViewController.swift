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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainScreenViewController()
    }
    
    func setupMainScreenViewController() {
        addTaskButton.layer.cornerRadius = 2
    }
    
    @IBAction func addTaskButtonTapped(_ sender: Any) {
        let controller = R.storyboard.main.addTaskViewController()!
        navigationController?.pushViewController(controller, animated: true)
    }
    

}

