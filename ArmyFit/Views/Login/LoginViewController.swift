//
//  LoginViewController.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 26/05/22.
//

import UIKit
import FirebaseCore
import GoogleSignIn

class LoginViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var registerScreen: UIStackView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    
    private let viewModel: LoginViewModel = .init()
    private var iconClick = false
    private let imageIcon = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        configViewModel()
        configGestureRecognizer()
        configureContentView()
        configureImageIcon()
    }
    
    //MARK: - Private methods
    @IBAction private func forgotPasswordButton(_ sender: UIButton) {
    }
    
    @IBAction private func loginButton(_ sender: UIButton) {
        viewModel.makeLoginRequest(
            emailTextField.text,
            passwordTextField.text)
        showActivityIndicator()
    }
    
    private func configViewModel() {
        viewModel.delegate = self
    }
    
    private func errorAlert() {
        let error = UIAlertController(
            title: "Acesso negado",
            message: "Dados incorretos, verifique e tente novamente!",
            preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .cancel)
        error.addAction(confirm)
        present(error, animated: true)
    }
    
    //-----> Start of show password configuration <-----//
    private func configureContentView() {
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        
        contentView.frame = CGRect(
            x: 100,
            y: 100,
            width: UIImage(systemName: "eye.slash")!.size.width,
            height: UIImage(systemName: "eye.slash")!.size.height
        )
        imageIcon.frame = CGRect(
            x: -10,
            y: 0,
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
    
    private func configureImageIcon() {
        imageIcon.image = UIImage(systemName: "eye.slash")
        imageIcon.tintColor = .black
    }
    
    @objc private func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
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
    //-----> End of show password configuration <-----//
    
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
    
    private func showActivityIndicator() {
        loginButton.setTitle("", for: .normal)
        spinner.layer.position = loginButton.layer.position
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
    }
    
    private func stopActivityIndicator() {
        spinner.stopAnimating()
        loginButton.setTitle("LOGIN", for: .normal)
    }
}

//MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {
    func successAuth() {        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mainTabBarController = storyboard.instantiateViewController(
            withIdentifier: "TabBarViewController") as? CustomTabBarViewController else { return }
        
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainTabBarController)
    }
    
    func errorAuth() {
        errorAlert()
        stopActivityIndicator()
    }
}
