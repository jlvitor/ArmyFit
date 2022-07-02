//
//  ProfileViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 05/06/22.
//

import UIKit
import PhotosUI
import KeychainSwift

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var profileTableView: UITableView!
    
    private let viewModel: ProfileViewModel = ProfileViewModel()
    private let keychain: KeychainSwift = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserImageViewBorder()
        configTableView()
        configUserData()
    }
    
    @IBAction func editProfileButtonAction(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    //MARK: - Private methods
    private func configTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func configUserImageViewBorder() {
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor(named: "light_background")?.cgColor
    }
    
    private func configUserData() {
        profileImageView.image = UIImage(named: viewModel.getUserImage())
        nameLabel.text = viewModel.getUserName()
    }
    
    private func showAlert() {
        let editProfileALert = UIAlertController(
            title: "Editar perfil",
            message: "Você deseja editar seu perfil?",
            preferredStyle: .actionSheet)
        
        let editImageProfileGallery = UIAlertAction(title: "Selecionar uma foto de perfil na galeria", style: .default) { action in
            self.openGalleryPickerView()
        }
        let editImageProfileCamera = UIAlertAction(title: "Tirar uma foto de perfil", style: .default) { action in
            self.openCameraPickerView()
        }
        let editNameProfile = UIAlertAction(title: "Editar nome de perfil", style: .default) { (action) in
            let alertController = UIAlertController(title: "Confirmação", message: "Digite seu novo nome de perfil", preferredStyle: .alert)
            
            alertController.addTextField { (textfield) in
                textfield.placeholder = "Digite seu nome"
            }
            
            let submit = UIAlertAction(title: "Ok", style: .default) { (action) in
                
                if let name = alertController.textFields?.first?.text {
                    self.nameLabel.text = String(name).uppercased()
                }
                
            }
            
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
                print("Operation has been cancelled")
            }
            alertController.addAction(submit)
            alertController.addAction(cancel)
            self.present(alertController, animated: true)
        }
        
        let cancelEdit = UIAlertAction(title: "Cancelar", style: .cancel)
        
        editProfileALert.addAction(editImageProfileGallery)
        editProfileALert.addAction(editImageProfileCamera)
        editProfileALert.addAction(editNameProfile)
        editProfileALert.addAction(cancelEdit)
        
        present(editProfileALert, animated: true)
    }

    private func openGalleryPickerView() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    private func openCameraPickerView() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { success, error in
                guard let image = success as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
        
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.originalImage] as? UIImage else { return }

        profileImageView.image = profileImage
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            if indexPath.row == 0 {
                UserDefaults.standard.resetAllValues()
                keychain.clear()
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainLoginVC = storyboard.instantiateViewController(
                    withIdentifier: "LoginNavigationController")
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.setRootViewController(mainLoginVC)
            }
        }
        if indexPath.section == 1 {
            if indexPath.row == 1 {
                viewModel.getWhatsapp()
            }
        }
        
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countRowsInSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCustomCell", for: indexPath) as? ProfileTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        let _cellViewModel = viewModel.profileInfo(at: section, at: row)
        
        cell?.configure(profileCellViewModel: _cellViewModel)
        
        return cell ?? UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = viewModel.setTilteForSection(section)
        return title
    }
}
