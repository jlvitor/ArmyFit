//
//  RegisterViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 26/05/22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var loginScreen: UIStackView!
    
    private let viewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.overrideUserInterfaceStyle = .light
        hideKeyboardWhenTappedAround()
        configGestureRecognizer()
        viewModel.delegate = self
    }
    
    //MARK: - Private methods
    @IBAction private func registerButton(_ sender: UIButton) {
        viewModel.makeRegisterRequest(
            nameTextField.text,
            emailTextField.text,
            passwordTextField.text)
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
    
    private func errorPasswordValidationAlert() {
        let error = UIAlertController(
            title: "Acesso negado",
            message: "Digite a mesma senha nos dois campos",
            preferredStyle: .alert)
        let confirm = UIAlertAction(
            title: "Ok",
            style:.cancel) { (action) in
                guard let password = self.passwordTextField.text,
                      let confirmPassword = self.confirmPasswordTextField.text else { return }
                self.viewModel.getPasswordValidation(password, confirmPassword)
            }
        error.addAction(confirm)
        present(error, animated: true, completion: nil)
    }
    
    private func configGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction(_:))
        )
        self.loginScreen.addGestureRecognizer(tap)
    }

    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - RegisterViewModelDelegate
extension RegisterViewController: RegisterViewModelDelegate {
    func successRegister() {
        performSegue(withIdentifier: "backToLoginScreen", sender: self)
    }
    
    func errorRegister() {
        showAlert() 
    }
}

extension RegisterViewController: PasswordValidationDelegate {
    func successPasswordValidation() {
        performSegue(withIdentifier: "backToLoginScreen", sender: self)
    }
    
    func errorPasswordValidation() {
        errorPasswordValidationAlert()
    }
    
    
}
