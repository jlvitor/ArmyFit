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
    
    private var iconClick =  false
    private let imageIcon = UIImageView()
    private var iconClick2 =  false
    private let imageIcon2 = UIImageView()
    private var alert: Alert?
    
    
    private let viewModel: RegisterViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configGestureRecognizer()
        configureViewModel()
        configureContentViewPassword()
        configureImageIcon()
        configureContentViewConfirmPassword()
        configureImageIcon2()
        
    }
    
    private func configureViewModel() {
        viewModel.delegate = self
        viewModel.validationDelegate = self
    }
    
    //MARK: - Toggle textfield password
        private func configureContentViewPassword() {
             let contentView = UIView()
             contentView.addSubview(imageIcon)
             
             contentView.frame = CGRect(x: 100,
                                        y: 100,
                                        width: UIImage(systemName: "eye.slash")!.size.width,
                                        height: UIImage(systemName: "eye.slash")!.size.width
             )
             
             imageIcon.frame = CGRect(x: -10,
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
             }
             else {
                 iconClick = true
                 tappedImage.image = UIImage(systemName: "eye.slash")
                 passwordTextField.isSecureTextEntry = true
                 
             }
         }
        
    //MARK: - Toggle textfield ConfirmPassword
        private func configureContentViewConfirmPassword() {
             let contentView = UIView()
             contentView.addSubview(imageIcon2)
             
             contentView.frame = CGRect(x: 100,
                                        y: 100,
                                        width: UIImage(systemName: "eye.slash")!.size.width,
                                        height: UIImage(systemName: "eye.slash")!.size.width
             )
             
             imageIcon2.frame = CGRect(x: -10,
                                      y: 0,
                                      width: UIImage(systemName: "eye.slash")!.size.width,
                                      height: UIImage(systemName: "eye.slash")!.size.height
             )
             
            confirmPasswordTextField.rightView = contentView
            confirmPasswordTextField.rightViewMode = .always
             
             let tapGestureRecognizer = UITapGestureRecognizer(
                 target: self,
                 action: #selector(imageTappedConfirm(tapGestureRecognizer:)))
             imageIcon2.isUserInteractionEnabled = true
             imageIcon2.addGestureRecognizer(tapGestureRecognizer)
         }
         private func configureImageIcon2() {
             imageIcon2.image = UIImage(systemName: "eye.slash")
             imageIcon2.tintColor = .black
         }
        @objc private func imageTappedConfirm(tapGestureRecognizer: UITapGestureRecognizer) {
             
             let tappedImage = tapGestureRecognizer.view as! UIImageView
             
             if iconClick2 {
                 iconClick2 = false
                 tappedImage.image = UIImage(systemName: "eye")
                 confirmPasswordTextField.isSecureTextEntry = false
             }
             else {
                 iconClick2 = true
                 tappedImage.image = UIImage(systemName: "eye.slash")
                 confirmPasswordTextField.isSecureTextEntry = true
                 
             }
         }
  
        
    @IBAction func registerButton(_ sender: UIButton) {
        viewModel.makeRegisterRequest(
            nameTextField.text,
            emailTextField.text,
            passwordTextField.text)
    }
    
    private func alertValidation() {
        alert?.getAlert(
            title: "Erro",
            message: "Não foi possível realizar o registro",
            completion: nil)
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
        self.loginScreen.addGestureRecognizer(tap)
    }

    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func successRegister() {
        performSegue(withIdentifier: "backToLoginScreen", sender: self)
    }
    
    func errorRegister() {
        showAlert() 
    }
}

extension RegisterViewController: ValidationTextFieldsDelegate {
    func successValidation() {
        viewModel.makeRegisterRequest(
            nameTextField.text,
            emailTextField.text,
            passwordTextField.text)
    }
    
    func errorValidation() {
        alertValidation()
    }
    
    
    
}
