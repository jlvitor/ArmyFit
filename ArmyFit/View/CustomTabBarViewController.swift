//
//  CustomTabBarViewController.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 28/05/22.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.layer.shadowOffset = CGSize.zero
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.5
    }
}
