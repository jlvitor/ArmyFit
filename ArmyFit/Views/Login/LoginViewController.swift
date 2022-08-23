//
//  LoginViewController.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 26/05/22.
//

import UIKit
import GoogleSignIn
import FacebookLogin

class LoginViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var googleLoginStackView: UIStackView!
    @IBOutlet private weak var facebookLoginStackView: UIStackView!
    @IBOutlet private weak var registerScreen: UIStackView!
    
    private let viewModel: LoginViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        configViewModel()
        configGestureRecognizer()
        configGoogleLoginGesture()
        configFacebookLoginGesture()
        passwordTextField.enablePasswordToggle()
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
        viewModel.googleDelegate = self
        viewModel.facebookDelegate = self
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
    
    private func errorRegisterAlert() {
        let error = UIAlertController(
            title: "Email já cadastrado",
            message: "Caso não lembre da senha você pode definir uma nova.",
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
    
    private func configGoogleLoginGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(googleLoginAction(_:))
        )
        self.googleLoginStackView.addGestureRecognizer(tap)
    }
    
    @objc private func googleLoginAction(_ sender: UITapGestureRecognizer) {
        viewModel.makeLoginGoogle()
    }
    
    private func configFacebookLoginGesture() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(facebookLoginAction(_:))
        )
        self.facebookLoginStackView.addGestureRecognizer(tap)
    }
    
    @objc private func facebookLoginAction(_ sender: UITapGestureRecognizer) {
        viewModel.makeLoginFacebook()
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
    
    // Login com Google
    func loginGoogle(with config: GIDConfiguration) {
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            self.viewModel.handleGoogleLogin(with: user, error: error)
        }
    }
    
    func loginFacebook() {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { result, error in
            self.viewModel.handleFacebookLogin(with: result, error: error)
        }
    }
}

//MARK: - GoogleLoginDelegate
extension LoginViewController: GoogleLoginDelegate {
    func googleSuccess() {
        guard let profile = viewModel.googleUser.profile else { return }
        
        viewModel.makeRegisterRequest(
            profile.name ,
            profile.email,
            viewModel.randomPassword,
            "\(profile.imageURL(withDimension: 100))"
        )
    }
    
    func googleError() {
        errorRegisterAlert()
    }
    
    func loginGoogleSuccess() {
        guard let profile = viewModel.googleUser.profile else { return }
        
        viewModel.makeLoginRequest(
            profile.email,
            viewModel.randomPassword) 
    }
    
    func loginGoogleError() {
        errorRegisterAlert()
    }
}

extension LoginViewController: FacebookLoginDelegate {
    func facebookSuccess() {
        let profile = viewModel.facebookUser
        
        viewModel.makeRegisterRequest(
            profile["name"] as? String ?? "",
            profile["email"] as? String ?? "",
            viewModel.randomPassword,
            "https://storage.googleapis.com/armyfit/profile.png")
    }
    
    func facebookError() {
        errorRegisterAlert()
    }
    
    func loginFacebookSuccess() {
        let profile = viewModel.facebookUser
        
        viewModel.makeLoginRequest(
            profile["email"] as? String ?? "",
            viewModel.randomPassword)
    }
    
    func loginFacebookError() {
        errorRegisterAlert()
    }
}
