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
    @IBOutlet weak var registerScreen: UIStackView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configGestureRecognizer()
       }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
        
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        
        let loginVC = FeedViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        
        }
    
    private func configGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction(_:))
        )
        self.view.addGestureRecognizer(tap)
                
        }
    
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
        
    }

}
