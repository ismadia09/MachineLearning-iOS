//
//  MachineLearningTabBarController.swift
//  MachineLearning
//
//  Created by Isma Dia on 07/12/2018.
//  Copyright © 2018 Isma Dia. All rights reserved.
//

import Foundation
import UIKit

class MachineLearningTabBarController: UITabBarController {
    let gameViewController = UINavigationController(rootViewController:GameViewController())
    let trainingViewController = UINavigationController(rootViewController:MainViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        gameViewController.tabBarItem = UITabBarItem(title: "Game", image: UIImage(named: "game_controller"), tag: 1)
        trainingViewController.tabBarItem = UITabBarItem(title: "Train", image: UIImage(named: "services"), tag: 2)
        viewControllers = [gameViewController,trainingViewController]
        
    }
}
