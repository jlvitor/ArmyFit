//
//  LoginViewController.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 26/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
    }
    
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let loginVC = FeedViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        
        }
    
}
