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
    
    private let viewModel: LoginViewModel = LoginViewModel()
    private var iconClick = false
    let imageIcon = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewModel()
        configGestureRecognizer()
        passwordTextField.isSecureTextEntry = true
        configureContentView()
        configureImageIcon()
    }
//MARK: - Toggle
    func configureContentView() {
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(
            x: 100,
            y: 100,
            width: UIImage(systemName: "eye.slash")!.size.width,
            height: UIImage(systemName: "eye.slash")!.size.width
        )
        imageIcon.frame = CGRect(
            x: -10,
            y: 5,
            width: UIImage(systemName: "eye.slash")!.size.width,
            height: UIImage(systemName: "eye.slash")!.size.height
        )
        
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(imageTapped(tapGestureRecognizer:)))
        imageIcon.isUserInteractionEnabled = true
        imageIcon.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func configureImageIcon() {
        imageIcon.image = UIImage(systemName: "eye.slash")
        imageIcon.tintColor = .black
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        if iconClick {
            iconClick = false
            tappedImage.image = UIImage(systemName: "eye")
            passwordTextField.isSecureTextEntry = false
        } else {
            iconClick = true
            tappedImage.image = UIImage(systemName: "eye.slash")
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func forgotPasswordButton(_ sender: UIButton) {
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        viewModel.makeLoginRequest(
            emailTextField.text,
            passwordTextField.text)
    }
    
    private func configViewModel() {
        viewModel.delegate = self
    }
    
    private func showAlert() {
        let error = UIAlertController(
          title: "Acesso negado",
          message: "Dados incorretos, verifique e tente novamente!",
          preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .cancel)
        error.addAction(confirm)
        present(error, animated: true)
      }
    
    private func configGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction(_:))
        )
        self.registerScreen.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToRegisterScreen", sender: self)
    }
    
}

extension LoginViewController: LoginViewModelDelegate {
    func successAuth() {
        performSegue(withIdentifier: "loginToHome", sender: self)
    }
    
    func errorAuth() {
        showAlert()
    }
    
    
}
